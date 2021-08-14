class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :teams

  validates :email, presence: true
  validates :email, uniqueness: true

  enum role: %i[standard admin]
end
