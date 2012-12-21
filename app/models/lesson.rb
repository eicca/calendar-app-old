class Lesson < ActiveRecord::Base

  module STATUS
    PENDING = 'pending'
    UPCOMING = 'upcoming'
    GONE = 'gone'
    COMPLETED = 'completed'

    NOT_STARTED = [PENDING, UPCOMING]
  end

  belongs_to :student
  belongs_to :teacher
  validates :start_at, :end_at, :teacher, :student, presence: true
  validate :no_conflicts_with_other_lessons
  validate :in_teacher_schedule
  attr_accessible :end_at, :teacher_id, :start_at, :title, :status

  before_create :set_pending_status
  after_create :notify_teacher_about_new_lesson

  def as_json(options = {})
    {
      id: id.to_s + ?l, # FIXME weird id passed to fc
      title: '',
      start: start_at.rfc822,
      end: end_at.rfc822,
      allDay: false,
      className: 'lessons-event',
      eventType: 'lesson'
    }
  end

  private

  def set_pending_status
    self.status = STATUS::PENDING
  end

  def notify_teacher_about_new_lesson
    LessonMailer.new_lesson(self).deliver
  end

  def in_teacher_schedule
    beginning_of_week = start_at.beginning_of_week
    minutes_before_start = (start_at - beginning_of_week) / 60
    minutes_before_end = (end_at - beginning_of_week) / 60

    available = teacher.schedules.where{ |schedules|
      (schedules.minutes_before_start <= minutes_before_start) &
      (schedules.minutes_before_end >= minutes_before_end)
    }.any?

    unless available
      errors.add(:base, 'not in working time')
    end
  end

  def no_conflicts_with_other_lessons
    available = teacher.lessons.where{ |lessons|
      (lessons.start_at < self.end_at) &
      (lessons.end_at > self.start_at) &
      (lessons.id != self.id)
    }.blank?
    unless available
      errors.add(:base, 'conflict with other lesson')
    end
  end

end
