class AddRemoveTripsColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :departure_location, :string
    add_column :trips, :arrival_location, :string
    add_column :trips, :distance, :string
    add_column :trips, :duration, :string
    add_column :trips, :completed, :boolean, default: false

    remove_column :trips, :start_odometer
    remove_column :trips, :end_odometer
    remove_column :trips, :start_comment
    remove_column :trips, :end_comment
    remove_column :trips, :active
  end
end
