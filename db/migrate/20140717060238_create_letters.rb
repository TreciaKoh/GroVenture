class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.string :name
      t.string :text

      t.timestamps
    end
  end
end
