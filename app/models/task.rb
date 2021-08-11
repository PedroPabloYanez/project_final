class Task < ApplicationRecord
    belongs_to :project

    validates :description, :due_date, presence: true
    
end
