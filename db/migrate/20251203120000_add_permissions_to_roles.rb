class AddPermissionsToRoles < ActiveRecord::Migration[7.2]
  def change
    add_column :roles, :permissions, :jsonb, default: {}, null: false
  end
end
