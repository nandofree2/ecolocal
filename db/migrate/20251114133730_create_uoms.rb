class CreateUoms < ActiveRecord::Migration[7.2]
  def change
    create_table :uoms do |t|
      t.string :name
      t.integer :quantity

      t.timestamps
    end
  end
end
