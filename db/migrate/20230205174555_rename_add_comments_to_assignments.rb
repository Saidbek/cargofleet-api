class RenameAddCommentsToAssignments < ActiveRecord::Migration[5.2]
  def change
    rename_column :assignments, :comment, :start_comment
    add_column :assignments, :end_comment, :string
  end
end
