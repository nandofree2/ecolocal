class CreateCities < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :cities, id: :uuid do |t|
      t.string :name
      t.string :sku
      t.text :description
      t.references :province, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
