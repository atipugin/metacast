class ApplicationUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    @fname ||= "#{md5}#{File.extname(super)}" if super
  end

  def md5
    @md5 ||= Digest::MD5.file(path)
  end
end
