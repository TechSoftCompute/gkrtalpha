class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.integer :liked
      t.integer :disliked
      t.integer :creator_id
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
