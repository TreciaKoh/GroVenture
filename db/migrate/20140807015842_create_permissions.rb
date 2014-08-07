class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :staffid
      t.string :permissions

      t.timestamps
    end
  end
end
