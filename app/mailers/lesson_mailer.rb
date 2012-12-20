class LessonMailer < ActionMailer::Base
  default from: 'Teacher Helper lessons@teacher-helper.dev'

  def new_lesson(lesson)
    @lesson = lesson
    @teacher = lesson.teacher
    @student = lesson.student

    mail to: @teacher.email,
         subject: 'You have new lesson request!'
  end

end
