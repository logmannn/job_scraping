class AddPinnedToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column(:jobs, :pinned, :boolean)
  end
end
