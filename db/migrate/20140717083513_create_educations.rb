class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.references :staff
      t.string :schoolname
      t.string :schooladdress
      t.string :level
      t.integer :from
      t.integer :to
      t.boolean :didyougraduate

      t.timestamps
    end
  end
end
