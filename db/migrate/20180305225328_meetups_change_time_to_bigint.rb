class MeetupsChangeTimeToBigint < ActiveRecord::Migration[5.1]
  def change
    remove_column(:meetups, :time, :int)
    add_column(:meetups, :time, :bigint)
  end
end
