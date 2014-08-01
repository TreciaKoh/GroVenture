class CreateReportsicks < ActiveRecord::Migration
  def change
    create_table :reportsicks do |t|
      t.string :staffid

      t.timestamps
    end
  end
end
