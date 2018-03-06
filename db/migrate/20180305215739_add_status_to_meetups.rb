class AddStatusToMeetups < ActiveRecord::Migration[5.1]
  def change
    add_column(:meetups, :status, :string)
  end
end
