class ChangeColumnNameInRoles < ActiveRecord::Migration
  def change
    rename_column :roles, :role, :account_type
  end
end
