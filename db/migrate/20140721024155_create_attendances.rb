class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.string :staffid
      t.string :timein
      t.string :leavetype

      t.timestamps
    end
  end
end
