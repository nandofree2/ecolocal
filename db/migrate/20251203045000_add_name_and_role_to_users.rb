class AddNameAndRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role_id, :uuid unless column_exists?(:users, :role_id)
    add_index :users, :role_id unless index_exists?(:users, :role_id)
    add_foreign_key :users, :roles, column: :role_id unless foreign_key_exists?(:users, :roles)
  end
end
