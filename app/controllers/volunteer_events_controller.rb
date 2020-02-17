class VolunteerEventsController < ApplicationController
  def index
    @events = VolunteerEvent.active.upcoming.order("event_start_at ASC")
    respond_to do |format|
      format.html
      format.json { render :json => @events.as_json(methods: [:name, :address, :formatted_time]) }
    end
  end

  def iframe
    index
    render :index, :layout => "iframe"
  end
end
