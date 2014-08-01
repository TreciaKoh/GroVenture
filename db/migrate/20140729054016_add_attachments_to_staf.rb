class AddAttachmentsToStaf < ActiveRecord::Migration
  def self.up
    add_attachment :staffs, :photo
    add_attachment :staffs, :icfront
    add_attachment :staffs, :icback
    add_attachment :staffs, :childbirthcert
  end

  def self.down
    remove_attachment :staffs, :photo
    remove_attachment :staffs, :icfront
    remove_attachment :staffs, :icback
    remove_attachment :staffs, :childbirthcert
  end
end
