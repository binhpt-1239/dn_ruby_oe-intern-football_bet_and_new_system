class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend

  before_action :set_locale

  private

  def logged_in_user
    action_if_not_logged_in unless logged_in?
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

  def upload_image image
    return unless image

    obj = S3_BUCKET.object("uploads_s3/#{image.original_filename}")
    obj.put(body: image)
  end
end
