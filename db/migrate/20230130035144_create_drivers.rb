class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.string :birth_date
      t.string :email
      t.string :phone_number
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.belongs_to :vehicle, foreign_key: true
      t.string :license_number
      t.string :license_class
      t.string :license_state

      t.timestamps
    end
  end
end
