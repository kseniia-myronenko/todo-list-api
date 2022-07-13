class ImageUploader < Shrine
  plugin :remove_attachment

  Attacher.validate do
    validate_mime_type Image::ALLOWED_MIME_TYPES
    validate_extension_inclusion Image::ALLOWED_EXTENSIONS
    validate_max_size Image::MAX_SIZE
  end
end
