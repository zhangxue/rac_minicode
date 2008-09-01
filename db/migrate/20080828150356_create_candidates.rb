class CreateCandidates < ActiveRecord::Migration
  def self.up
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.integer :status, :default=>0

      t.timestamps
    end
  end

  def self.down
    drop_table :candidates
  end
end
