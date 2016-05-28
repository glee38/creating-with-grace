class CreateArtMedia < ActiveRecord::Migration
  def change
    create_table :art_media do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
