class AddStatusToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :status, :integer, default: 0
  end
end
