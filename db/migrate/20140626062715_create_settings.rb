class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :numtiers
      t.integer :nummonths

      t.timestamps
    end
  end
end
