class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.belongs_to :vehicle, foreign_key: true
      t.string :title
      t.text :description
      t.integer :priority
      t.datetime :reported_at

      t.timestamps
    end
  end
end
