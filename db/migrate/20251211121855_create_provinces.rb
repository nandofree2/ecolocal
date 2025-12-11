class CreateProvinces < ActiveRecord::Migration[7.2]
  def change
    create_table :provinces do |t|
      t.string :name
      t.string :sku
      t.text :description

      t.timestamps
    end
  end
end
