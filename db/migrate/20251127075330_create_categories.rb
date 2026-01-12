class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :categories, id: :uuid do |t|
      t.string :name
      t.string :sku
      t.text :description

      t.timestamps
    end

    add_index :categories, :sku, unique: true
  end
end
