class CreateUnitOfMeasurements < ActiveRecord::Migration[7.2]
  def change
    create_table :unit_of_measurements do |t|
      t.string :name
      t.string :sku
      t.integer :quantity

      t.timestamps
    end

    add_index :unit_of_measurements, :sku, unique: true
  end
end
