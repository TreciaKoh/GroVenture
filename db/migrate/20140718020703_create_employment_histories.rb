class CreateEmploymentHistories < ActiveRecord::Migration
  def change
    create_table :employment_histories do |t|
      t.references :staff, index: true
      t.string :employername
      t.string :employeraddress
      t.string :position
      t.integer :from
      t.integer :to
      t.integer :salary
      t.string :reasonforleaving

      t.timestamps
    end
  end
end
