class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :address
      t.integer :patient_id

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
