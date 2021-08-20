class ChangeTeamsUsersTable < ActiveRecord::Migration[5.2]
  def change
    rename_table 'teams_users', 'team_users'
    add_column :team_users, :id, :primary_key
  end
end
