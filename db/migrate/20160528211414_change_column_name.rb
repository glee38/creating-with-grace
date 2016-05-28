class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :type, :art_media_id
  end
end
