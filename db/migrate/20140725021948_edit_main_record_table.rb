class EditMainRecordTable < ActiveRecord::Migration
  def change
    remove_column :main_records, :closed
    add_column :main_records, :closedamount, :decimal, :precision => 10, :scale => 2
    add_column :main_records, :invoiceno, :string 
    remove_column :main_record_gros, :closed
    add_column :main_record_gros, :closedamount, :decimal, :precision => 10, :scale => 2
    add_column :main_record_gros, :invoiceno, :string 
  end
end
