class AddClosedNotClosed < ActiveRecord::Migration
  def change
    add_column :main_records, :closed, :boolean
    add_column :main_record_gros, :closed, :boolean
  end
end
