class CreateExtraleaves < ActiveRecord::Migration
  def change
    create_table :extraleaves do |t|
      t.string :staffid
      t.integer :leave
      t.string :reason

      t.timestamps
    end
  end
end
