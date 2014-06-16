class AddColumnsToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :fullname, :string
    add_column :staffs, :nric, :string
    add_column :staffs, :dob, :date
    add_column :staffs, :dateemployed, :date
    add_column :staffs, :dobchild, :date
  end
end
