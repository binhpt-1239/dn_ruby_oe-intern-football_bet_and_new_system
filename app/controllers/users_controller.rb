class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :logged_in_user, only: :show

  def show; end
end
