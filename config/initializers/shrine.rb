require 'shrine'

if Rails.env.development?
  require 'shrine/storage/file_system'

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads') # permanent
  }

elsif Rails.env.test?
  require 'shrine/storage/memory'

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }

else
  require 'shrine/storage/s3'
  s3_options = {
    access_key_id: Rails.application.credentials.aws.access_key_id,
    secret_access_key: Rails.application.credentials.aws.secret_access_key,
    region: Rails.application.credentials.aws.region,
    bucket: Rails.application.credentials.aws.bucket
  }
  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: 'store', **s3_options)
  }
end

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :determine_mime_type, analyzer: :marcel
Shrine.plugin :validation_helpers, default_messages: {
  max_size: ->(max) { I18n.t('activerecord.errors.models.image.too_large', max_size: max) },
  mime_types: ->(list) { I18n.t('activerecord.errors.models.image.not_image', allowed_types: list) },
  extensions: ->(list) { I18n.t('activerecord.errors.models.image.wrong_extension', allowed_types: list) }
}
