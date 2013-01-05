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

  def reschedule
    if @lesson.update_attributes(params[:lesson])
      @lesson.status = Lesson::STATUS::PENDING
      @lesson.save!
      LessonMailer.change_request(@lesson).deliver
    end
    respond_with @lesson
  end

end
