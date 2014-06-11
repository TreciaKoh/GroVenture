class CreateMainRecordGros < ActiveRecord::Migration
  def change
    create_table :main_record_gros do |t|
      t.integer :recordId
      t.string :companyName
      t.string :address
      t.string :postalCode
      t.string :contactPerson
      t.string :position
      t.string :hp
      t.string :office
      t.string :email
      t.string :apptBy
      t.datetime :dateAppt
      t.string :remarks
      t.string :attendedBy
      t.string :attendedByGrade
      t.string :attendedByRemarks

      t.timestamps
    end
  end
end
