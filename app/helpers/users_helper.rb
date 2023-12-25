module UsersHelper
  include Rails.application.routes.url_helpers

  def gravatar_for user
    return unless user.thumbnail.present?

    image_tag(rails_blob_path(user.thumbnail, disposition: "attachment", only_path: true), alt: user.name, class: "gravatar", style: 'height:100%;width:50px;')
  end

  def sum_amount user
    money_add = sum_with_type(user, :payment)
    money_take = sum_with_type(user, :withdrawal)
    money_win = sum_with_type(user, :win)
    money_lose = sum_with_type(user, :lose)
    (money_add + money_win) - (money_take + money_lose)
  end

  private

  def sum_with_type user, type
    user.currencies.search_by_type(type).sum(:amount)
  end

  def file_from_s3 user
    # Handle get file from s3
    signer = Aws::S3::Presigner.new
    gravatar_url = signer.presigned_url(:get_object, bucket: ENV["BUCKET_NAME"], key: user.image || "uploads_s3/Barca1.png")
  end
end
