class HomeController < ApplicationController
  def index
    @events = HouseEvent.active.upcoming.order("created_at ASC").all
  end

  def events
    @events = HouseEvent.all #Rails.root.join("lib/fixtures/events.json").read
    render :json => @events
  end
end
