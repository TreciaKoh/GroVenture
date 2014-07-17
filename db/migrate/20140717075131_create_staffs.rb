class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :positionapplied
      t.string :salutation
      t.string :fullname
      t.string :address
      t.integer :telephone
      t.date :dob
      t.string :birthplace
      t.string :race
      t.string :dialect
      t.string :nric
      t.string :colour
      t.string :citizenship
      t.string :sex
      t.string :religion
      t.string :incometaxno
      t.string :drivinglicenseno
      t.string :maritalstatus
      t.string :spousename
      t.string :spouseoccupation
      t.integer :noofchildren
      t.string :agerange
      t.string :emergencyname
      t.string :emergencyrelationship
      t.string :emergencyaddress
      t.integer :emergencytelephone
      t.boolean :servingbond
      t.integer :salaryexpected
      t.date :dateavailable
      t.boolean :previousapplied
      t.date :previousdate
      t.string :previousposition
      t.string :languagespoken
      t.string :languagewritten
      t.string :physicaldisability
      t.string :majorillness
      t.string :staffid
      t.string :password
      t.string :profession
      t.string :company
      t.date :dateemployed
      t.date :dobchild
      t.string :department
      t.integer :tier
      t.decimal :overwrittenleave, :scale => 2, :precision => 5
      t.date :overwrittenon

      t.timestamps
    end
  end
end
