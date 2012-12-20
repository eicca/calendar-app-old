class LessonsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @lessons = current_user.lessons
    index!
  end

  def new
    @teacher = Teacher.find_by_id(params[:teacher_id])
    new!
  end

  def create
    @lesson = Lesson.new params[:lesson]
    @lesson.student = current_student
    create!
  end

  def accept
    if @lesson.update_attributes(status: Lesson::STATUS::UPCOMING)
      LessonMailer.lesson_accepted(@lesson).deliver
      redirect_to lessons_path, notice: 'Lesson request accepted'
    else
      redirect_to lessons_path, error: 'Lesson was not been accepted'
    end
  end

  def confirm
    if @lesson.update_attributes(status: Lesson::STATUS::COMPLETED)
      LessonMailer.lesson_completed(@lesson).deliver
      redirect_to lessons_path, notice: 'Lesson marked as completed'
    else
      redirect_to lessons_path, error: 'Lesson was not been completed'
    end
  end

end
