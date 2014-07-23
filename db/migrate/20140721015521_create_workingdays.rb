class CreateWorkingdays < ActiveRecord::Migration
  def change
    create_table :workingdays do |t|
      t.string :department
      t.integer :year
      t.string :month
      t.integer :days

      t.timestamps
    end
  end
end
