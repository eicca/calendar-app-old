class SchedulesController < InheritedResources::Base
  respond_to :json
  belongs_to :teacher

end
