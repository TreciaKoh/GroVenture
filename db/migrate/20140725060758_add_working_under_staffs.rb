class AddWorkingUnderStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :workingunder, :string
  end
end
