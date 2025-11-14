class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.text :description
      t.string :status
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
