class CreateHouseEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :house_events do |t|
      t.string :first_name
      t.string :last_name
      t.string :cohosts, array:true, default: []

      t.string :email
      t.string :phone
      t.string :volunteer

      t.string :address_street
      t.string :address_unit_number
      t.string :address_city
      t.string :address_state
      t.string :address_zip
      t.datetime :event_start_at
      t.datetime :event_end_at
      t.text :description
      t.string :event_link



      t.float :latitude
      t.float :longitude




      t.timestamps
    end
  end
end
