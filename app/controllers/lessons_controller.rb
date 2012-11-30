class LessonsController < InheritedResources::Base
  respond_to :html, :json

  def create
    @lesson = Lesson.new params[:lesson]
    @lesson.student = current_student
    create!
  end
end
