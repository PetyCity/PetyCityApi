CarrierWave.configure  do |config|

  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJU6BX6ALRABEYOEQ',                        # required
    aws_secret_access_key: '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',                        # required
  }
  config.fog_directory  = 'petycitybucket'                # required
end
