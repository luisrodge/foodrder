class PrimaryImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  process resize_to_fit: [800, 800]

  version :medium do
    process resize_to_fill: [300, 240]
  end

  version :thumb do
    process resize_to_fill: [60, 60]
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
