class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  check_authorization unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden, content_type: "text/html"}
      format.html{redirect_to main_app.root_url, notice: exception.message}
      format.js{head :forbidden, content_type: "text/html"}
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password,
                   :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def logged_in_user
    action_if_not_logged_in unless user_signed_in?
  end

  def action_if_not_logged_in
    store_location
    flash[:danger] = t "notification.log_in.request"
    redirect_to login_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
    locale = params[:locale].to_s.strip.to_sym
    d_local = I18n.default_locale
    I18n.locale = I18n.available_locales.include?(locale) ? locale : d_local
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
