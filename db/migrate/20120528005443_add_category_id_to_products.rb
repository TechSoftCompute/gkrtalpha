class AddCategoryIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
    rename_column :comments,:creator,:creator_id
  end
end
