class DropPostThumbnailsTable < ActiveRecord::Migration
  def change
    drop_table :post_thumbnails
  end
end
