class Staffleavedbjoin < ActiveRecord::Migration
  def change
    add_reference :leaves, :staff, index: true
  end
end
