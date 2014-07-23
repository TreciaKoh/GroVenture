class AddColumns < ActiveRecord::Migration
  def change
    add_column :staffpays, :EmployerCpf, :decimal, precision: 10, scale: 2
    add_column :staffpays, :EmployeeCpf, :decimal, precision: 10, scale: 2
    add_column :staffpays, :deduction, :decimal, :precision => 10, :scale => 2
  end
end
