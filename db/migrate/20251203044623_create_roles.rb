class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :roles, id: :uuid do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
