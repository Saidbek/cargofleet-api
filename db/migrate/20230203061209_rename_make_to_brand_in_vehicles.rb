class RenameMakeToBrandInVehicles < ActiveRecord::Migration[5.2]
  def change
    rename_column :vehicles, :make, :brand
  end
end
