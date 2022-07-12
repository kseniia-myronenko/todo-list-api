class FileUploader < Shrine
  ALLOWED_MIME_TYPES = %w[image/jpeg image/png].freeze
  ALLOWED_EXTENSIONS = %w[jpg jpeg png].freeze
  MAX_SIZE = 10 * 1024 * 1024

  Attacher.validate do
    validate_mime_type ALLOWED_MIME_TYPES
    validate_extension_inclusion ALLOWED_EXTENSIONS
    validate_max_size MAX_SIZE
  end
end
