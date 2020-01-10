class HomeController < ApplicationController
  def index
    @events = JSON.parse(Rails.root.join("lib/fixtures/events.json").read)
  end

  def events
    @events = Rails.root.join("lib/fixtures/events.json").read
    render :json => @events
  end
end
