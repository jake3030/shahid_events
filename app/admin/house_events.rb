ActiveAdmin.register HouseEvent do
  permit_params :name, :address, :event_date
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :address, :event_date, :lat, :lon
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :event_date, :lat, :lon]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form title: 'A custom title' do |f|
    inputs 'Details' do
      input :email
      input :phone
      input :first_name
      input :last_name
      input :address_street
      input :address_unit_number
      input :address_city
      input :address_state, collection: state_options
      input :address_zip

      li "Created at #{f.object.created_at}" unless f.object.new_record?
      input :event_start_at, as: :date_time_picker
      input :event_end_at, as: :date_time_picker

      input :description
      input :event_link
    end

    # panel 'Markup' do
#       "The following can be used in the content below..."
#     end
#     inputs 'Content', :address
#     para "Press cancel to return to the list without saving."
    actions
  end


end
