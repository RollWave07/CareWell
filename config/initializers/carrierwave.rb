CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV['AS3_ACCESS_KEY'],
    aws_secret_access_key: ENV['AS3_SECRET_ACCESS_KEY']
  }
  config.fog_directory = ENV['AS3_BUCKET_NAME']
end