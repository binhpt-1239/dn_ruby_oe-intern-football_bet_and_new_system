class UsersController < ApplicationController
  before_action :logged_in_user, only: :show

  def show; end
end
