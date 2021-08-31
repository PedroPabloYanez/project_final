class Task < ApplicationRecord
  belongs_to :project
  
  enum status: [:not_started, :in_progress, :complete]

  def badge_color
    case status
    when 'not_started'
      'secondary'
    when 'in_progress'
      'info'
    when 'complete'
      'success'
    end
  end
      
  def complete?
    status == 'complete'
  end
    
  def in_progress?
    status == 'in-progress'
  end
    
  def not_started?
    status == 'not-started'
  end

  def count_down_day_task
    primero = Date.today
    segundo = self.due_date
    resultado = (segundo - primero).to_i
    
    resultado
  end
    
end
