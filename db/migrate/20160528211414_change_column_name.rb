class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :type, :art_medium
  end
end
