class CreatePostThumbnails < ActiveRecord::Migration
  def change
    create_table :post_thumbnails do |t|
      t.string :thumbnail
      t.integer :post_id
      t.timestamps null: false
    end
  end
end
