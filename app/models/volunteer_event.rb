class VolunteerEvent < ApplicationRecord
  store :extras, accessors: [:an_response], coder: JSON

  validates_uniqueness_of :action_network_id
  geocoded_by :address
  after_validation :geocode, latitude: :lat, longitude: :lon

  scope :upcoming, -> () {
    where("event_start_at > ?", Time.now.beginning_of_day)
  }
  scope :active, -> () {
    where("event_start_at IS NOT NULL")
  }

  class << self
    def import_from_an
      client = ActionNetworkClient.new
      client.fetch_events
      events = client.events
      create_events_from_an(events)
    end

    def create_events_from_an(events)
      events.each do |ev|
        next if Time.parse(ev["start_date"]) < Time.parse("10/02/2020")
        self.new.from_an(ev).save
      end
    end
  end

  def from_an(attrs)
    self.action_network_id = attrs["identifiers"].first
    self.title = attrs["title"]
    self.description = attrs["description"]
    self.name = attrs["name"]
    self.event_start_at = attrs["start_date"]
    self.url = attrs["browser_url"]
    self.image_url = attrs["featured_image_url"]
    self.venue = attrs.dig("location", "venue")
    self.longitude = attrs.dig("location", "location", "longitude")
    self.latitude = attrs.dig("location", "location", "latitude")
    self.address_street = attrs.dig("location", "address_lines").first
    self.address_city = attrs.dig("location", "locality")
    self.address_state = attrs.dig("location", "region")
    self.address_zip = attrs.dig("location", "postal_code")
    self
  end

  def address
    [address_street, address_city, address_state, address_zip].compact.join(", ")
  end

  def start_time
    event_start_at.strftime("%l:%m %p")
  end

  def end_time
    event_end_at&.strftime("%l:%m %p")
  end

  def formatted_time
    "#{event_start_at.to_date} from #{start_time} - #{end_time}"
  end

end
