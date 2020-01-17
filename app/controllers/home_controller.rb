class HomeController < ApplicationController
  def index
    @events = HouseEvent.active.upcoming.order("created_at ASC").all
  end

  def events
    @events = HouseEvent.active.upcoming.all #Rails.root.join("lib/fixtures/events.json").read
    render :json => @events.as_json(methods: [:name, :address, :formatted_time])
  end
end
