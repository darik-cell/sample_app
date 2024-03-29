#При развертывании на хероку надо указать переменные ENV: heroku config:set S3_ACCESS_KEY=<access key>
# чтобы не светить конф. инфой
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Настройка для Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key => ENV['S3_SECRET_KEY']
    }
    config.fog_directory     =  ENV['S3_BUCKET']
  end
end