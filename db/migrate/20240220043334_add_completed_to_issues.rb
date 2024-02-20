class AddCompletedToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :completed, :boolean, default: false
  end
end
