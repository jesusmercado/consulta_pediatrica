class CreateDiagnostics < ActiveRecord::Migration
  def self.up
    create_table :diagnostics do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :diagnostics
  end
end
