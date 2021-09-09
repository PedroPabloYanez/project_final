class Project < ApplicationRecord
  validates :name, presence: true
  validates :initial_date, presence: true
  validates :finish_date, presence: true
  acts_as_votable
  has_many :tasks
  belongs_to :team
  belongs_to :user

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

  def percent_complete
    return 0 if tasks.none?
    ((total_complete.to_f / total_tasks) * 100).round
  end
  
  def total_complete
    tasks.select { |task| task.complete? }.count
  end
  
  def total_tasks
    tasks.count
  end

  def total_day
    primero = self.initial_date
    segundo = self.finish_date
    resultado = (segundo - primero + 1).to_i
    resultado
  end

  def count_down_day
    primero = Date.today
    segundo = self.finish_date
    resultado = (segundo - primero).to_i
    if status == 'complete'
      resultado = 0
    end
    resultado
  end

  def self.project_not_started_count
    Project.where(status: "not_started").count
  end
  
  def self.project_in_progress_count
    Project.where(status: "in_progress").count
  end
  
  def self.project_complete_count
    Project.where(status: "complete").count
  end

end
