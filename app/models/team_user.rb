class TeamUser < ApplicationRecord
    belongs_to :team, dependent: :destroy
    belongs_to :user, dependent: :destroy
end