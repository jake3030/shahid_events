class ActionNetworkClient
  include HTTParty
  base_uri 'https://actionnetwork.org/api/v2/'

  headers 'Content-Type' => 'application/json'
  headers 'OSDI-API-Token' => ENV["ACTION_NETWORK_API"]

  def initialize(opts = {})
    @options = opts
    @response = nil
  end

  def fetch_events(options = {})
    options.merge!(@options)
    @response = self.class.get('/events', options)
  end

  def fetch_event(id, options = {})
    options.merge!(@options)
    self.class.get("/events/#{id}", options)
  end

  def next_page?
    !next_page.blank?
  end

  def next_page
    @response.dig("_links", "next", "href")
  end

  def fetch_next_page
    return unless next_page?
    @response = self.class.get(next_page)
  end

  def events
    return if @response.empty?
    @response.dig("_embedded", "osdi:events")
  end
end