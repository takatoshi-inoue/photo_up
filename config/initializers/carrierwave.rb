# require 'carrierwave/storage/abstract'
# require 'carrierwave/storage/file'
# require 'carrierwave/storage/fog'

# CarrierWave.configure do |config|
#   config.storage = :fog
#   config.fog_provider = 'fog/aws'
#   config.fog_credentials = {
#     provider: 'AWS',
#     aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#     aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#     region: 'ap-northeast-1'
#   }

#   config.fog_directory  = 'photoupbox'
#   config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/photoupbox'
# end

require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test? #開発とテストは今まで通りに
    config.storage = :file
  elsif Rails.env.production? #本番はS3に保存する
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
# credentials下にaws_access_key_idとaws_secret_access_keyはあるよ
      region: 'ap-northeast-1'
    }
    config.fog_directory  = 's3バケット名'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/s3バケット名'
  end
end