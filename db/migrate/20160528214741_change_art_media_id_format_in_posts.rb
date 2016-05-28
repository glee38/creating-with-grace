class ChangeArtMediaIdFormatInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :art_media_id, :integer
  end
end
