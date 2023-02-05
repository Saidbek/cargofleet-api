class AddAccountId < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :account_id, :integer
    add_index  :vehicles, :account_id

    add_column :issues, :account_id, :integer
    add_index  :issues, :account_id

    add_column :drivers, :account_id, :integer
    add_index  :drivers, :account_id
  end
end
