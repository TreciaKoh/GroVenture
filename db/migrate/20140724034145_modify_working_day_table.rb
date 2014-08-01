class ModifyWorkingDayTable < ActiveRecord::Migration
  def change
    add_column :workingdays, :days2, :integer
  end
end
