class CreateBlockedLeaves < ActiveRecord::Migration
  def change
    create_table :blocked_leaves do |t|
      t.date :date
      t.string :profession

      t.timestamps
    end
  end
end
