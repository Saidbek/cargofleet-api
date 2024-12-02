class AddCompletedAtToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :completed_at, :datetime
  end
end
