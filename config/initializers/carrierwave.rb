CarrierWave.configure  do |config|

  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAIN2TY5GCMZWGGS5A',                        # required
    aws_secret_access_key: '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',                        # required
  }
  config.fog_directory  = 'petycity2017'                # required
end
