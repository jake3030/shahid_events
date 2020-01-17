module LoadFromCsv
  extend ActiveSupport::Concern

  class_methods do
    def load_from_csv
      CSV.foreach(Rails.root.join("lib/fixtures", "2020_events.csv"), headers: true) do |row|
        puts row.to_h
        attrs = attrs_from_row(row)
        he = HouseEvent.new(attrs)
        he.save(validate: false)
      end
      HouseEvent.all.map {|he| he.geocode; he.save(validate: false)}
    end

    def attrs_from_row(row)
      attrs = {
        :first_name => row["First Name"],
        :last_name => row["Last name"],
        :email => row["Email"],
        :phone => row["Phone"],
        :cohosts => create_cohosts(row),
        :event_link => row["Invitation Link"]
      }
      attrs = attrs.merge(event_info(row))
      attrs = attrs.merge(address_info(row))
      attrs
    end

    def create_cohosts(row)
      return [] if row["Cohosts"].blank?
      row["Cohosts"].split(",")
    end

    def event_info(row)
      return {} if row["Date"].blank? || row["Time"].blank?

      am_or_pm = row["Time"].scan(/pm/).first
      start_time, end_time = row["Time"].gsub(/am|pm/, "").split("-").map {|str| str.size == 1 ? str + ":00" : str}
      start_date = Time.strptime([row["Date"], start_time, am_or_pm].join(" "), "%m/%d/%y %I:%M %p")
      end_date = Time.strptime([row["Date"], end_time, am_or_pm].join(" "), "%m/%d/%y %I:%M %p")
      {
        event_start_at: start_date,
        event_end_at: end_date,
      }
    rescue ArgumentError => e
      puts "event_info failed: #{e}"
      return {}
    end

    def address_info(row)
      {
        address_street: row["Address"],
        address_city: row["City"] == "SF" ? "San Francisco" : row["City"],
        address_state: "CA",
        address_zip: nil,
      }
    end
  end
end
