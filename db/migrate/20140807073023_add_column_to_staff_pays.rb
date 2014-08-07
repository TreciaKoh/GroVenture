class AddColumnToStaffPays < ActiveRecord::Migration
  def change
    add_column :staffpays, :target, :decimal, :scale=>2, :precision=>10
  end
end
