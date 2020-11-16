require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    AWS_ACCESS_KEY_ID_MER60 = 'i-08f38b93ae5eb1ff5'
    AWS_SECRET_ACCESS_KEY_MER60 = 'c429d386e1ecda5f0b742c79331d4e460cbeae5d2235b892f0fc45ea166ee3b71d3b99299ed1ca70b0e82a45bcd1934e7779c5386734d25faef47dcb89dfa7d0',
    # aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    # aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'photoupbox'
  config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/photoupbox'
end