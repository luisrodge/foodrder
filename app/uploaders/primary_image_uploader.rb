class PrimaryImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  process resize_to_fit: [800, 800]

  version :medium do
    eager
    process resize_to_fill: [400, 320]
    cloudinary_transformation :quality => 100
  end

  version :thumb do
    eager
    process resize_to_fill: [60, 60]
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
