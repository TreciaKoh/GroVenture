class CreateLoginLogs < ActiveRecord::Migration
  def change
    create_table :login_logs do |t|
      t.string :userid
      t.datetime :logintime

      t.timestamps
    end
  end
end
