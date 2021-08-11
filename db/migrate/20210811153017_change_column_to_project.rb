class ChangeColumnToProject < ActiveRecord::Migration[5.2]
  def change
    rename_column :projects, :finish, :finish_date
  end
end
