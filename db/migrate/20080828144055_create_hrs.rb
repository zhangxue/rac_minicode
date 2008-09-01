class CreateHrs < ActiveRecord::Migration
  def self.up
    create_table "hrs", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime


    end
    add_index :hrs, :login, :unique => true
    
    Hr.create(:login=>'admin',:name=>'RAC HR',:email=>'jobs@richapplicationconsulting.com',:password=>'123456',:password_confirmation=>'123456')
  end

  def self.down
    drop_table "hrs"
  end
end
