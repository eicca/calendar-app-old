class Schedule < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :end_at, :recurring, :start_at, :title

  validates :start_at, :end_at, :teacher, :minutes_before_start,
    :minutes_before_end, presence: true
  validate :one_schedule_in_one_time

  # FIXME seems in some rare cases it may not work if we want to
  # not use validation (like in update_all)
  before_validation :calculate_minutes

  def as_json(options = {})
    # FIXME timezone issue
    beginning_of_week = options[:beginning_of_week] ||
      start_at.beginning_of_week.advance(hours: 4)

    start_datetime = beginning_of_week.advance(minutes: minutes_before_start)
    end_datetime = beginning_of_week.advance(minutes: minutes_before_end)

    {
      id: id,
      start: start_datetime,
      end: end_datetime,
      recurring: recurring
    }
  end

  private

  def calculate_minutes
    beginning_of_week = start_at.beginning_of_week
    self.minutes_before_start = (start_at - beginning_of_week) / 60
    self.minutes_before_end = (end_at - beginning_of_week) / 60

    self.recurring = true
    true
  end

  def one_schedule_in_one_time
    available = teacher.schedules.where{ |schedules|
      (schedules.minutes_before_start < self.minutes_before_end) &
      (schedules.minutes_before_end > self.minutes_before_start) &
      (schedules.id != self.id)
    }.blank?
    unless available
      errors.add(:base, 'conflict with other schedule')
    end
  end

end
