class ChangeStatusFieldType < ActiveRecord::Migration
  def change
    change_column :leaves, :approved, :integer
  end
end
