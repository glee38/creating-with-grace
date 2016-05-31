# encoding: utf-8

class ThumbnailUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
    include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   def unsharp_mask(radius, sigma, amount, threshold)
      # refer to this http://www.imagemagick.org/Usage/resize/#resize_unsharp
      manipulate! do |img|
        img.unsharp_mask radius, sigma, amount, threshold
        img = yield(img) if block_given?
        img
      end
    end

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]

  version :large do
    process resize_to_fill: [710, 477]
    process :quality => 100 
    process :unsharp_mask => [0.0, 0.75, 0.75, 0.008]
  end

  version :thumb do
    process resize_to_fill: [199, 277]
    process quality: 100
    process :unsharp_mask => [0.0, 0.5, 0.5, 0.008]
  end


  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
