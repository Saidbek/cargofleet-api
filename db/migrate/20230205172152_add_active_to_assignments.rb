class AddActiveToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :active, :boolean, default: true
  end
end
