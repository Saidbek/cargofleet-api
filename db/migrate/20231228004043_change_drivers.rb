class ChangeDrivers < ActiveRecord::Migration[5.2]
  def change
    remove_column :drivers, :active
    remove_column :drivers, :license_state
  end
end
