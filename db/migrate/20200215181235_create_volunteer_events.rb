class CreateVolunteerEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :volunteer_events do |t|
      t.string :action_network_id


      t.string :title
      t.string :name
      t.text :description

      t.datetime :event_start_at
      t.datetime :event_end_at

      t.string :venue
      t.string :address_street
      t.string :address_city
      t.string :address_state, default: "CA", null: false
      t.string :address_zip
      t.float :latitude
      t.float :longitude


      t.string :url
      t.string :image_url

      t.jsonb :extras

      t.timestamps
    end
  end
end
