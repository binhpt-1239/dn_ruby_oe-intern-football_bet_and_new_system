class SessionsController < ApplicationController
  include SessionsHelper
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      login_succes user
    else
      flash.now[:danger] = t "notification.log_in.err"
      render :new
    end
  end

  def destroy
    action_sign_out if logged_in?
    redirect_to root_url
  end

  private

  def action_sign_out
    log_out
    flash[:success] = t "notification.log_in.out_success"
  end

  def login_succes user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to root_path
    flash[:success] = t "notification.log_in.success"
  end
end
