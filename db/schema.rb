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

ActiveRecord::Schema.define(:version => 20121226110455) do

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.datetime "start_at",   :null => false
    t.datetime "end_at",     :null => false
    t.string   "status"
    t.integer  "student_id", :null => false
    t.integer  "teacher_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lessons", ["student_id"], :name => "index_lessons_on_student_id"
  add_index "lessons", ["teacher_id"], :name => "index_lessons_on_teacher_id"

  create_table "schedules", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "title"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "minutes_before_start"
    t.integer  "minutes_before_end"
    t.boolean  "recurring"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "schedules", ["teacher_id"], :name => "index_schedules_on_teacher_id"

  create_table "students", :force => true do |t|
    t.string   "name",                   :default => "",    :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "balance_cents",          :default => 0,     :null => false
    t.string   "balance_currency",       :default => "USD", :null => false
  end

  add_index "students", ["email"], :name => "index_students_on_email", :unique => true
  add_index "students", ["reset_password_token"], :name => "index_students_on_reset_password_token", :unique => true

  create_table "teachers", :force => true do |t|
    t.string   "name",                   :default => "",    :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "balance_cents",          :default => 0,     :null => false
    t.string   "balance_currency",       :default => "USD", :null => false
    t.integer  "price_cents",            :default => 0,     :null => false
    t.string   "price_currency",         :default => "USD", :null => false
  end

  add_index "teachers", ["email"], :name => "index_teachers_on_email", :unique => true
  add_index "teachers", ["reset_password_token"], :name => "index_teachers_on_reset_password_token", :unique => true

end
