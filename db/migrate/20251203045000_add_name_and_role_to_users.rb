class AddNameAndRoleToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role_id, :bigint unless column_exists?(:users, :role_id)
    add_index :users, :role_id unless index_exists?(:users, :role_id)
  end
end
