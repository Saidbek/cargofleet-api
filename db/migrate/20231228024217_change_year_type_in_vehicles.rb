class ChangeYearTypeInVehicles < ActiveRecord::Migration[5.2]
  def change
    change_column :vehicles, :manufacture_year, :datetime
  end
end
