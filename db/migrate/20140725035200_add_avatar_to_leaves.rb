class AddAvatarToLeaves < ActiveRecord::Migration
 
    def self.up
      add_attachment :leaves, :avatar
    end

    def self.down
      remove_attachment :leaves, :avatar
    end
  
end
