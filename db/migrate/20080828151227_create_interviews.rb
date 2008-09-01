class CreateInterviews < ActiveRecord::Migration
  def self.up
    create_table :interviews do |t|
      t.integer :candidate_id
      t.string :token      
      t.string :education
      t.string :country
      t.string :city
      t.string :time_zone
      t.string :years_of_working
      t.text :working_experiences
      t.string :profile
      t.integer :expected_salary
      t.string :available_within

      t.timestamps
    end
  end

  def self.down
    drop_table :interviews
  end
end
