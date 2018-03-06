class RemoveDistanceFromMeetups < ActiveRecord::Migration[5.1]
  def change
    remove_column(:meetups, :distance, :float)
  end
end
