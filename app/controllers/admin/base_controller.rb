class Admin::BaseController < ApplicationController
  before_action :loged_in?, :is_admin?

  private

  def loged_in?
    return if current_user

    flash[:danger] = t ".request_login"
    redirect_to root_path
  end

  def is_admin?
    return if current_user.admin

    flash[:danger] = t ".not_allow"
    redirect_to root_path
  end
end
