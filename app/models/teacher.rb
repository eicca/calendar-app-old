class Teacher < ActiveRecord::Base
  has_many :schedules
  has_many :lessons
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  monetize :balance_cents

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
