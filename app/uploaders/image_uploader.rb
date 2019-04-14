class ImageUploader < ApplicationUploader
  include CarrierWave::MiniMagick

  version :itunes do
    process resize_to_fill: [1400, 1400]
  end

  version :thumb do
    process resize_to_fill: [128, 128]
  end

  def default_url
    ActionController::Base.helpers.asset_path(
      File.join(
        'fallback', 'image', [version_name, 'default.png'].compact.join('_')
      )
    )
  end
end
