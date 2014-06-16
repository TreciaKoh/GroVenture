class AddApprovedToLeave < ActiveRecord::Migration
  def change
    add_column :leaves, :approved, :boolean
  end
end
