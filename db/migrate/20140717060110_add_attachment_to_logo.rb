class AddAttachmentToLogo < ActiveRecord::Migration
  def self.up
    add_attachment :logos, :supportdoc
  end

  def self.down
    remove_attachment :logos, :supportdoc
  end
end
