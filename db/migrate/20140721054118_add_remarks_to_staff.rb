class AddRemarksToStaff < ActiveRecord::Migration
  def change
    add_column :staffs, :remarks, :string
  end
end
