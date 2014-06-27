class AddColumnsToStaffMore < ActiveRecord::Migration
  def change
    add_column :staffs, :department, :string
    add_column :staffs, :workingunder, :string
    add_column :staffs, :tier, :integer
    add_column :staffs, :overwritttenleave, :decimal, precision: 5, scale: 2
    add_column :staffs, :overwrittenon, :date
  end
end
