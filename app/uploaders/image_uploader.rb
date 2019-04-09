class ImageUploader < ApplicationUploader
  include CarrierWave::MiniMagick

  version :itunes do
    process resize_to_fill: [1400, 1400]
  end
end
