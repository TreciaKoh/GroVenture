class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :staffpays, :cpf
  end
end
