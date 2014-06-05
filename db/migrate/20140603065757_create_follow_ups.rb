class CreateFollowUps < ActiveRecord::Migration
  def change
    create_table :follow_ups do |t|
      t.integer :recordId
      t.datetime :dateFollowUp
      t.string :remarks

      t.timestamps
    end
  end
end
