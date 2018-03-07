class MeetupMembers < ActiveRecord::Migration[5.1]
  def change
    create_table(:meetup_members) do |t|
      t.column(:name, :string)
      t.column(:city, :string)
      t.column(:state, :string)
      t.column(:country, :int)
      t.column(:linkedin_user_id, :integer)
    end
  end
end
