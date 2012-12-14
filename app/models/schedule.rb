class Schedule < ActiveRecord::Base
  belongs_to :teacher
  attr_accessible :end_at, :recurring, :start_at, :title

  validates :start_at, :end_at, :teacher, presence: true
  validate :validate_datetime_interval

  def as_json(options = {})
    {
      id: id,
      title: '',
      start: start_at.rfc822,
      end: end_at.rfc822,
      recurring: recurring,
      allDay: false,
      #className: 'teachers-event'
    }
  end

  private

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
