class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.text :description
      t.integer :status_product, default: 0, null: false
      t.integer :quantity
      t.decimal :price
      t.references :category, null: false, foreign_key: true
      t.references :unit_of_measurement, null: false, foreign_key: true
      t.timestamps
    end

    add_index :products, [:unit_of_measurement_id, :category_id]
  end
end
