class ChangeColumnNameInLeave < ActiveRecord::Migration
  def change
    rename_column :leaves, :type, :leavetype
  end
end
