class CreateTelepays < ActiveRecord::Migration
  def change
    create_table :telepays do |t|
      t.integer :teleid
      t.decimal :basic, precision: 10, scale: 2
      t.decimal :cpf, precision: 10, scale: 2
      t.decimal :attendance, precision: 10, scale: 2
      t.decimal :performance, precision: 10, scale: 2
      t.decimal :commission, precision: 10, scale: 2

      t.timestamps
    end
  end
end
