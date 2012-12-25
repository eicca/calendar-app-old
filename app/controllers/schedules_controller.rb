class SchedulesController < InheritedResources::Base
  load_and_authorize_resource
  respond_to :json, :html
  belongs_to :teacher

  def index
    index! do |format|
      # FIXME!!!! fix timezone issues
      format.json {
        opts = { beginning_of_week: Time.parse(params[:date_start]
                                              ).advance(hours: 4) }
        render json: collection.to_json(opts) 
      }
    end
  end

end
