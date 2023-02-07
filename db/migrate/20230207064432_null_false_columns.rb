class NullFalseColumns < ActiveRecord::Migration[5.2]
  def change
    # drivers
    change_column_null :drivers, :first_name, false
    change_column_null :drivers, :last_name, false
    change_column_null :drivers, :birth_date, false
    change_column_null :drivers, :email, false
    change_column_null :drivers, :address1, false
    change_column_null :drivers, :city, false
    change_column_null :drivers, :state, false
    change_column_null :drivers, :postal_code, false
    change_column_null :drivers, :license_number, false
    change_column_null :drivers, :account_id, false

    # issues
    change_column_null :issues, :vehicle_id, false
    change_column_null :issues, :title, false
    change_column_null :issues, :priority, false
    change_column_null :issues, :reported_at, false
    change_column_null :issues, :account_id, false

    # vehicles
    change_column_null :vehicles, :brand, false
    change_column_null :vehicles, :model, false
    change_column_null :vehicles, :manufacture_year, false
    change_column_null :vehicles, :color, false
    change_column_null :vehicles, :plate_number, false
    change_column_null :vehicles, :engine_number, false
    change_column_null :vehicles, :fuel_type, false
    change_column_null :vehicles, :account_id, false
  end
end
