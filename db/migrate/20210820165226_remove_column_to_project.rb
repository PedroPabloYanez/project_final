class RemoveColumnToProject < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :status
  end
end
