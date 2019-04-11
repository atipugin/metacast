class ImageUploader < ApplicationUploader
  include CarrierWave::MiniMagick

  version :itunes do
    process resize_to_fill: [1400, 1400]
  end

  version :thumb do
    process resize_to_fill: [128, 128]
  end
end
