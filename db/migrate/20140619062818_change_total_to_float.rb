class ChangeTotalToFloat < ActiveRecord::Migration
  def change
    change_column :leaves, :total, :decimal, precision: 5, scale: 2
  end
end
