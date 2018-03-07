class AddLinks < ActiveRecord::Migration[5.1]
  def change
    add_column(:jobs, :link, :string)
  end
end
