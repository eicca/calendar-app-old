class LessonsController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :html, :json

  def new
    @teacher = Teacher.find_by_id(params[:teacher_id])
    new!
  end

  def create
    @lesson = Lesson.new params[:lesson]
    @lesson.student = current_student
    create!
  end

end
