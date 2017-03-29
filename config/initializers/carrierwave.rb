module CarrierWave
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end
  end
end

# NullStorage provider for CarrierWave for use in tests. Doesn't actually
# upload or store files but allows test to pass as if the files were stored
class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    file = Rails.root.join('test', 'fixtures', 'files', 'blank.jpg')
    tmp = Rails.root.join('tmp', 'blank_tmp.jpg')
    FileUtils.cp(file, tmp)
    CarrierWave::SanitizedFile.new(tmp)
  end
end

CarrierWave.configure do |config|
  # Use local storage in development and test environment
  if Rails.env.development?
    config.storage = :file
  end

  if Rails.env.test?
    config.storage = NullStorage
    config.enable_processing = false
  end

  # Use AWS storage if in production
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.secrets.aws_access_key_id,
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,
      region: 'eu-west-1'
    }
    config.fog_directory = Rails.application.secrets.aws_s3_bucket_name

    config.storage = :fog
  end
end
