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

  def self.task_not_started_count
    Task.where(status: "not_started").count
  end
  
  def task_in_progress_count
    self.where(status: "in_progress").count
  end
  
  def self.task_complete_count
    self.where(status: "complete").count
  end
    
end
