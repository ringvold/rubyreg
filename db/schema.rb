# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121118141944) do

  create_table "event_types", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title",         :null => false
    t.string   "description"
    t.date     "start_date",    :null => false
    t.date     "end_date",      :null => false
    t.integer  "max_att",       :null => false
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "replies_count"
  end

  create_table "field_replies", :force => true do |t|
    t.integer  "field_id"
    t.integer  "reply_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_types", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "field_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fields", :force => true do |t|
    t.string   "field_label",   :null => false
    t.string   "field_order",   :null => false
    t.string   "description"
    t.boolean  "required",      :null => false
    t.integer  "event_id",      :null => false
    t.integer  "field_type_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "replies", :force => true do |t|
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                             :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "role",                            :default => "admin"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"

end
