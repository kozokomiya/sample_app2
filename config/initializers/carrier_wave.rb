if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['us-west-2'],     # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['AKIAIZ6HRUEYLV5VVQMA'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['kk-rails-2nd-picture']
  end
end