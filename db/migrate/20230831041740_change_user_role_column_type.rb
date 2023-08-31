class ChangeUserRoleColumnType < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :new_role, :integer
    remove_column :users, :role
    rename_column :users, :new_role, :role
  end
end
