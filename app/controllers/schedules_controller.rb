class SchedulesController < InheritedResources::Base
  respond_to :json

  protected
  def begin_of_association_chain
    current_teacher
  end
end
