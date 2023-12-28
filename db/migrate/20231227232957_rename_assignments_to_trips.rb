class RenameAssignmentsToTrips < ActiveRecord::Migration[5.2]
  def change
    rename_table :assignments, :trips
  end
end
