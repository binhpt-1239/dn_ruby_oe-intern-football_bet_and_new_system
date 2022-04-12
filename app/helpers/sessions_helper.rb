module SessionsHelper
  def log_in user
    sign_in user
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    current_user.present?
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    session.delete :user_id
    forget @current_user
    @current_user = nil
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
