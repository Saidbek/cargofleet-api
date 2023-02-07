class RenameReportedAtAgain < ActiveRecord::Migration[5.2]
  def change
    rename_column :issues, :reported_at, :due_date
  end
end
