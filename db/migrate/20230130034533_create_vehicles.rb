class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.date :manufacture_year
      t.string :color
      t.string :image
      t.string :plate_number
      t.string :engine_number
      t.integer :fuel_type

      t.timestamps
    end
  end
end
