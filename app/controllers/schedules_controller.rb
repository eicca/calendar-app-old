class SchedulesController < InheritedResources::Base
  respond_to :json
  belongs_to :teacher

  def index
    index! do |format|
      # FIXME!!!! fix timezone issues
      date_start = Time.parse(params[:date_start]).advance(hours: 4)
      format.json { render json: collection.to_json(date_start: date_start) }
    end
  end

end
