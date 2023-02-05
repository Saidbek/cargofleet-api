class RenameStatusInVehicles < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :status
    add_column :vehicles, :active, :boolean, default: true
  end
end
