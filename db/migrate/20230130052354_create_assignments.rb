class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :driver, foreign_key: true
      t.references :vehicle, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :start_odometer
      t.integer :end_odometer
      t.text :comment

      t.timestamps
    end
  end
end
