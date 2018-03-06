class CreateMeetups < ActiveRecord::Migration[5.1]
  def change
    create_table(:meetups) do |t|
      t.column(:utc_offset, :integer)
      t.column(:time, :int) #seconds

      t.column(:event_url, :string)
      t.column(:name, :string)
      t.column(:group_id, :int)
      t.column(:description, :string)
      t.column(:yes_rsvp_count, :integer)
      
      t.column(:distance, :float) #from search location in miles
      t.column(:venue_name, :string)
      t.column(:venue_city, :string)
      t.column(:venue_state, :string)
      t.column(:venue_zip, :string)
      t.column(:venue_country, :string)
      t.column(:venue_address_1, :string)
    end
  end
end
