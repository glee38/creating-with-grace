class ChangeColumnNameInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :art_media_id, :art_medium_id
  end
end
