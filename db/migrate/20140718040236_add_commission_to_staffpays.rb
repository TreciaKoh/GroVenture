class AddCommissionToStaffpays < ActiveRecord::Migration
  def change
    add_column :staffpays, :commission, :decimal, precision:10, scale: 2
  end
end
