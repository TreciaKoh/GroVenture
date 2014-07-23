class CreateStaffpays < ActiveRecord::Migration
  def change
    create_table :staffpays do |t|
      t.integer :staffid
      t.decimal :basic, precision: 10, scale: 2
      t.decimal :cpf, precision: 10, scale: 2
      t.decimal :attendance, precision: 10, scale: 2
      t.decimal :performance, precision: 10, scale: 2

      t.timestamps
    end
  end
end
