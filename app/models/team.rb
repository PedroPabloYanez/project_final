class Team < ApplicationRecord
    has_many :projects
	has_many :team_users
    has_many :users, through: :team_users


    def add_user(user_id)
        user= User.find(user_id)
        #if user
            #creamos la orden con los datos del productos según queramos mostar
            team_users.create(user_id: user.id)
        #end
    end
end
