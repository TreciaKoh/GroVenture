class AddTypeToLeave < ActiveRecord::Migration
  def change
    add_column :leaves, :type, :string
  end
end
