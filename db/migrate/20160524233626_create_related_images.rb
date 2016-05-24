class CreateRelatedImages < ActiveRecord::Migration
  def change
    create_table :related_images do |t|
      t.string :image
      t.integer :post_id
      t.integer :user_id
      t.text :caption
      t.timestamps null: false
    end
  end
end
