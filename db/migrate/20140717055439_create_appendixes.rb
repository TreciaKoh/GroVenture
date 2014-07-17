class CreateAppendixes < ActiveRecord::Migration
  def change
    create_table :appendixes do |t|
      t.string :name

      t.timestamps
    end
  end
end
