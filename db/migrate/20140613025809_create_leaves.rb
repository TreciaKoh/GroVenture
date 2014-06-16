class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :staffid
      t.string :company
      t.string :profession
      t.date :datestart
      t.date :dateend
      t.integer :total
      t.string :reason

      t.timestamps
    end
  end
end
