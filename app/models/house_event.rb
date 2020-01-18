class HouseEvent < ApplicationRecord
  include LoadFromCsv
  validates_presence_of :email, :phone, :first_name, :last_name, :event_start_at, :event_end_at,
  :address_street, :address_city, :address_state, :address_zip


  geocoded_by :address
  after_validation :geocode, latitude: :lat, longitude: :lon

  scope :upcoming, -> () {
    where("event_start_at > ?", Time.now.beginning_of_day)
  }
  scope :active, -> () {
    where("event_start_at IS NOT NULL")
  }



  def address
    [address_street, address_city, address_state, address_zip].compact.join(", ")
  end

  def start_time
    event_start_at.strftime("%l:%m %p")
  end

  def end_time
    event_end_at.strftime("%l:%m %p")
  end

  def formatted_time
    "#{event_start_at.to_date} from #{start_time} - #{end_time}"
  end

  def name
    [first_name, last_name].join(" ")
  end

end
