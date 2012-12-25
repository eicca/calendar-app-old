class LessonMailer < ActionMailer::Base
  default from: 'Teacher Helper lessons@teacher-helper.dev'

  def new_lesson(lesson)
    init lesson
    mail to: @teacher.email,
         subject: 'You have new lesson request!'
  end

  def lesson_accepted(lesson)
    init lesson
    mail to: @student.email,
         subject: 'Your lesson request accepted!'
  end

  def lesson_completed(lesson)
    init lesson
    mail to: @teacher.email,
         subject: 'Your lesson successfully completed!'
  end

  private

  def init(lesson)
    @lesson = lesson
    @teacher = lesson.teacher
    @student = lesson.student
  end

end
