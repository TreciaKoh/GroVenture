class CreateTelemarketers < ActiveRecord::Migration
  def change
    create_table :telemarketers do |t|
      t.string :teleid
      t.string :password

      t.timestamps
    end
  end
end
