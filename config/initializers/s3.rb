
CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => 'AKIAIR2LG77QWJO3SD5A',
      :aws_secret_access_key  => '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',
      :region                 => 'eu-west-1' 
  }
  config.fog_directory  = 'variations'
end