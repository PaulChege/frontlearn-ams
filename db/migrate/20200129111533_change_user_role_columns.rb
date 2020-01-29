class ChangeUserRoleColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :admin_role, :boolean
    remove_column :users, :teacher_role, :boolean
    add_column :users, :role, :integer
  end
end
