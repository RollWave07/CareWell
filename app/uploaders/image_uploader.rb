# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [400, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :sm_thumb do
    process :resize_to_fill => [50,50]
  end
  version :thumb do
    process :resize_to_fill => [50, 75]
  end
  version :sq_thumb do
    process :resize_to_fill => [60, 60]
  end
  version :medium do
    process :resize_to_fill => [70, 100]
  end
  version :sq_medium do
    process :resize_to_fill => [75, 75]
  end
  version :wide do
    process :resize_to_fit => [400, 300]
  end
  version :group do
    process :resize_to_fill => [400, 250]
  end
  version :group_logo do
    process :resize_to_fill => [130, 80]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "image.jpg" if original_filename
  end
end