require 'image_processing/mini_magick'

class ImageUploader < Shrine
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    Image::THUMBNAIL_SIZE.transform_values do |value|
      magick.resize_to_fill!(*value)
    end
  end

  Attacher.validate do
    validate_mime_type Image::ALLOWED_MIME_TYPES
    validate_extension_inclusion Image::ALLOWED_EXTENSIONS
    validate_max_size Image::MAX_SIZE
  end
end
