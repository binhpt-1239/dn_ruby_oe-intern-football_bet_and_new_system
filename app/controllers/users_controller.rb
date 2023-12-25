class UsersController < ApplicationController
  before_action :logged_in_user, only: :show

  def show; end

  def update
    handle_upload_to_storage_to_s3
    redirect_to user_path(current_user)
  end

  private

  # Handle upload file to s3
  def handle_upload_to_s3
    image = params.dig(:user, :images)
    return unless image.is_a?(ActionDispatch::Http::UploadedFile)

    upload_image image
    current_user.update_columns(image: "uploads_s3/#{image.original_filename}")
  end

  # Handle upload file to storage to s3
  def handle_upload_to_storage_to_s3
    current_user.update(thumbnail: params.dig(:user, :thumbnail))
  end
end
