class ChangeIssues < ActiveRecord::Migration[5.2]
  def change
    remove_column :issues, :title
    change_column_null :issues, :description, false
  end
end
