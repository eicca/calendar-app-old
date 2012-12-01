class Lesson < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  validates :title, :start_at, :end_at, :teacher, :student, presence: true
  validate :validate_datetime_interval
  attr_accessible :end_at, :teacher_id, :start_at, :title

  def as_json(options = {})
    {
      id: id.to_s + ?l,
      title: title,
      start: start_at.rfc822,
      end: end_at.rfc822,
      allDay: false,
      className: 'lessons-event',
      editable: true
    }
  end

  private
  def validate_datetime_interval
    available = teacher.schedules.where{|q| (q.start_at <= start_at) & (q.end_at >= end_at) }.any?
    unless available
      errors.add(:base, 'not in working time')
      return
    end
    available = teacher.lessons.where{ |q|
      (q.start_at < end_at) & (q.end_at > start_at) & (q.id != id)
    }.blank?
    unless available
      errors.add(:base, 'conflict with other lesson')
      return
    end
  end

end
