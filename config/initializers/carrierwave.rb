CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIN2YS7NECOIKXHKA',       # required
    :aws_secret_access_key  => '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',       # required
    # :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'gajubookmarklet'                     # required
  # config.fog_host       = 'https://assets.example.com'            # optional, defaults to nil
  # config.fog_public     = true                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}


  config.cache_dir = "#{Rails.root}/tmp/uploads"
end