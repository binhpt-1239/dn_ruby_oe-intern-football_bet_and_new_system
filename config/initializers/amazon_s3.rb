require "aws-sdk"

S3_CLIENT = Aws::S3::Client.new(
  region: ENV["AWS_REGION"]
)

S3_RESOURCE = Aws::S3::Resource.new client: S3_CLIENT
S3_BUCKET = S3_RESOURCE.bucket ENV["BUCKET_NAME"]
