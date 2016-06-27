class AddSlugToArtMedia < ActiveRecord::Migration
  def change
    add_column :art_media, :slug, :string
    add_index :art_media, :slug
  end
end
