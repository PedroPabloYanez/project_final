class Team < ApplicationRecord
    #paginates_per 5
    has_many :projects
	has_many :team_users, dependent: :destroy
    has_many :users, through: :team_users, dependent: :destroy
    

    def add_user(user_id)
        user= User.find(user_id)
        team_users.create(user_id: user.id)
    end
end
