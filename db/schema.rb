# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080828151227) do

  create_table "candidates", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "status",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hrs", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "hrs", ["login"], :name => "index_hrs_on_login", :unique => true

  create_table "interviews", :force => true do |t|
    t.integer  "candidate_id"
    t.string   "token"
    t.string   "education"
    t.string   "country"
    t.string   "city"
    t.string   "time_zone"
    t.string   "years_of_working"
    t.text     "working_experiences"
    t.string   "profile"
    t.integer  "expected_salary"
    t.string   "available_within"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
