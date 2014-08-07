class AddOnHoldColumn < ActiveRecord::Migration
  def change
    add_column :main_records, :onhold, :boolean
    add_column :main_record_gros, :onhold, :boolean
  end
end
