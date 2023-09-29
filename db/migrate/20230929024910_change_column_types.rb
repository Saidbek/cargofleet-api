class ChangeColumnTypes < ActiveRecord::Migration[5.2]
  def change
    change_column :assignments, :start_odometer, :string
    change_column :assignments, :end_odometer, :string
    change_column :assignments, :start_comment, :string
  end
end
