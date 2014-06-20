class AddHalfDayColumns < ActiveRecord::Migration
  def change
    add_column :leaves, :starttime, :string
    add_column :leaves, :endtime, :string
  end
end
