class AddNullifyToAssignments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :assignments, :driver_id, false
    change_column_null :assignments, :vehicle_id, false
    change_column_null :assignments, :vehicle_id, false

  end
end
