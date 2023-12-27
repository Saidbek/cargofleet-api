class DropVehicleColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :brand
    remove_column :vehicles, :color
  end
end
