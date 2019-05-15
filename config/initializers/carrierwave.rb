CarrierWave.configure do |config|
  config.storage = :aws
  config.asset_host = 'https://dlqied8bscuk8.cloudfront.net'
  config.aws_bucket = ENV['S3_BUCKET_NAME']
  config.aws_acl = 'public-read'
  config.aws_credentials = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION'],
    stub_responses: Rails.env.test?
  }
end
