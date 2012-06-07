class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.integer :cost
      t.string :category
      t.text :description
      t.string :url
      t.string :image_src
      t.timestamps
    end
  end
end
