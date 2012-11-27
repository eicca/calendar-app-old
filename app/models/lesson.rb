class Lesson < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  attr_accessible :completed, :duration, :start_at
end
