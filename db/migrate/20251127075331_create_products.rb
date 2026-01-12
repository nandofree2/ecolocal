class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :products, id: :uuid do |t|
      t.string :name
      t.string :sku
      t.text :description
      t.integer :status_product, default: 0, null: false
      t.decimal :price
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.references :unit_of_measurement, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end

    add_index :products, [:unit_of_measurement_id, :category_id]
  end
end
