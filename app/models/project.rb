class Project < ApplicationRecord
    validates :name, presence: true
    
    has_many :tasks
    belongs_to :team
    belongs_to :user

    def badge_color
      case status
      when 'not-started'
        'secondary'
      when 'in-progress'
        'info'
      when 'complete'
        'success'
      end
    end

    def status
        return 'not-started' if tasks.none?
        if tasks.all? { |task| task.complete? }
          'complete'
        elsif tasks.any? { |task| task.in_progress? || task.complete? }
          'in-progress'
        else
          'not-started'
        end
      end
end
