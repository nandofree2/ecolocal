class CreateUnitOfMeasurements < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :unit_of_measurements, id: :uuid do |t|
      t.string :name
      t.string :sku
      t.integer :quantity

      t.timestamps
    end

    add_index :unit_of_measurements, :sku, unique: true
  end
end
