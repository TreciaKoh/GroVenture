class ChangeLetterToLongText < ActiveRecord::Migration
  def change
    change_column :letters, :text, :longtext
  end
end
