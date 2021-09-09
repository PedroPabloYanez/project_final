class Task < ApplicationRecord
  belongs_to :project
  
  enum status: [:not_started, :in_progress, :complete]

  validates :due_date, presence: true

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

  def badge_color_priority
    case priority
    when 'Alta'
      'danger'
    when 'Media'
      'warning'
    when 'Baja'
      'dark'
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
    if status == 'complete'
      resultado = 0
    end
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
