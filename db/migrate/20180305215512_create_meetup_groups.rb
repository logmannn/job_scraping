class CreateMeetupGroups < ActiveRecord::Migration[5.1]
  def change
    create_table(:meetup_groups) do |t|
      t.column(:group_url, :string)
      t.column(:name, :string)
    end
  end
end
