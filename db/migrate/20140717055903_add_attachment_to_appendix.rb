class AddAttachmentToAppendix < ActiveRecord::Migration
  def self.up
    add_attachment :appendixes, :supportdoc
  end

  def self.down
    remove_attachment :appendixes, :supportdoc
  end
end
