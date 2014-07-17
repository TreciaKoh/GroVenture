class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.string :name

      t.timestamps
    end
  end
end
