class Teacher < ActiveRecord::Base
  serialize :schedule, Hash
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  #def schedule=(new_schedule)
    #write_attribute(:schedule, new_schedule.to_hash)
  #end

  #def schedule
    #read_attribute(:schedule)
  #end
end
