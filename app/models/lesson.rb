class Lesson < ActiveRecord::Base

  module STATUS
    PENDING = 'pending'
    PLANNED = 'planned'
  end

  belongs_to :student
  belongs_to :teacher
  validates :start_at, :end_at, :teacher, :student, presence: true
  validate :validate_datetime_interval
  attr_accessible :end_at, :teacher_id, :start_at, :title

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

  def validate_datetime_interval
  # TODO check recurrent dates
    #available = teacher.schedules.where{|q| (q.start_at <= start_at) & (q.end_at >= end_at) }.any?
    #unless available
      #errors.add(:base, 'not in working time')
      #return
    #end
    available = teacher.lessons.where{ |q|
      (q.start_at < end_at) & (q.end_at > start_at) & (q.id != id)
    }.blank?
    unless available
      errors.add(:base, 'conflict with other lesson')
      return
    end
  end

end
