class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :sku
      t.text :description

      t.timestamps
    end

    add_index :categories, :sku, unique: true
  end
end
