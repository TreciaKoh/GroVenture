class AddColumnsToRecords < ActiveRecord::Migration
  def change
    add_column :main_records, :closed, :boolean
    add_column :main_records, :depositbreakdown, :string
    add_column :main_record_gros, :closed, :boolean
    add_column :main_record_gros, :depositbreakdown, :string
  end
end
