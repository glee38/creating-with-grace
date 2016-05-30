class CreatePostThumbnails < ActiveRecord::Migration
  def change
    create_table :post_thumbnails do |t|

      t.timestamps null: false
    end
  end
end
