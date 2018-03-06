class CreateJobsTable < ActiveRecord::Migration[5.1]
  def change
    create_table(:jobs) do |t|
      t.column(:title, :string)
      t.column(:summary, :string)
      t.column(:company, :string)
      t.column(:days_posted, :string)
      t.column(:location, :string)
    end
  end
end
