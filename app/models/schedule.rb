class Schedule < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :end_at, :recurring, :start_at, :title

  validates :start_at, :end_at, :teacher, presence: true
  validate :validate_datetime_interval

  #before_save :calculate_dates

  def as_json(options = {})
    beginning_of_week = start_at.beginning_of_week
    secs_before_start = start_at - beginning_of_week
    secs_before_end = end_at - beginning_of_week
    date_start = options[:date_start] || beginning_of_week
    {
      id: id,
      title: '',
      #start: start_at.rfc822,
      #end: end_at.rfc822,
      start: date_start.advance(seconds: secs_before_start).rfc822,
      end: date_start.advance(seconds: secs_before_end).rfc822,
      recurring: recurring,
      allDay: false
      #className: 'teachers-event'
    }
  end


  private

  #TODO cache seconds calculation here
  def calculate_dates
    beginning_of_week = start_at.beginning_of_week
    self.seconds_before_start = start_at - beginning_of_week
    self.seconds_before_end = end_at - beginning_of_week

    self.recurring = true
  end

  def validate_datetime_interval
    available = teacher.schedules.where{ |q|
      (q.start_at < end_at) & (q.end_at > start_at) & (q.id != id)
    }.blank?
    unless available
      errors.add(:base, 'conflict with other schedule')
      return
    end
  end

end
