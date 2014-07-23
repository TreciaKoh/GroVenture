class A < ActiveRecord::Migration
  def change
    remove_column :staffpays, :EmployerCpf
    remove_column :staffpays, :EmployeeCpf
    add_column :staffpays, :employerCpf, :decimal, :precision => 10, :scale => 2
    add_column :staffpays, :employeeCpf, :decimal, :precision => 10, :scale => 2
  end
end
