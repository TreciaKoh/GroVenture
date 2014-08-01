class AddValidTillForExtraLeaves < ActiveRecord::Migration
  def change
    add_column :extraleaves, :validtill, :date
  end
end
