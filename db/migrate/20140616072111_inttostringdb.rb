class Inttostringdb < ActiveRecord::Migration
  def change
    change_column :leaves, :staff_id, :string
  end
end
