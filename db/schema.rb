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

ActiveRecord::Schema.define(:version => 20120409122140) do

  create_table "activities", :force => true do |t|
    t.integer  "participation_id"
    t.text     "text",             :default => "", :null => false
    t.integer  "status",           :default => 1,  :null => false
    t.integer  "user_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "activities", ["participation_id"], :name => "index_activities_on_participation_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.integer "country_id"
    t.string  "slug"
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"
  add_index "cities", ["slug"], :name => "index_cities_on_slug", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "comments", ["target_id"], :name => "index_comments_on_target_id"
  add_index "comments", ["target_type"], :name => "index_comments_on_target_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "countries", :force => true do |t|
    t.string "name"
    t.string "code"
    t.string "slug"
  end

  add_index "countries", ["slug"], :name => "index_countries_on_slug", :unique => true

  create_table "participations", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "status",     :default => 1, :null => false
  end

  add_index "participations", ["task_id"], :name => "index_participations_on_task_id"
  add_index "participations", ["user_id"], :name => "index_participations_on_user_id"

  create_table "problems", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "problems", ["user_id"], :name => "index_problems_on_user_id"

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status",      :default => 1, :null => false
    t.integer  "problem_id"
    t.integer  "user_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "slug"
    t.integer  "city_id"
  end

  add_index "projects", ["city_id"], :name => "index_projects_on_city_id"
  add_index "projects", ["problem_id"], :name => "index_projects_on_problem_id"
  add_index "projects", ["slug"], :name => "index_projects_on_slug", :unique => true
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "related_events", :force => true do |t|
    t.integer  "e_type"
    t.boolean  "read"
    t.integer  "readable_id"
    t.string   "readable_type"
    t.integer  "reader_id"
    t.string   "reader_type"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "related_events", ["readable_id"], :name => "index_related_events_on_readable_id"
  add_index "related_events", ["readable_type"], :name => "index_related_events_on_readable_type"
  add_index "related_events", ["reader_id"], :name => "index_related_events_on_reader_id"
  add_index "related_events", ["reader_type"], :name => "index_related_events_on_reader_type"
  add_index "related_events", ["user_id"], :name => "index_related_events_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status",      :default => 1, :null => false
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "slug"
    t.integer  "city_id"
  end

  add_index "tasks", ["city_id"], :name => "index_tasks_on_city_id"
  add_index "tasks", ["project_id"], :name => "index_tasks_on_project_id"
  add_index "tasks", ["slug"], :name => "index_tasks_on_slug", :unique => true
  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "user_infos", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "about_myself"
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "website"
    t.integer  "city_id"
  end

  add_index "user_infos", ["city_id"], :name => "index_user_infos_on_city_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "nickname",               :default => "", :null => false
    t.integer  "rating",                 :default => 0,  :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.boolean  "positive"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "votes", ["target_id"], :name => "index_votes_on_target_id"
  add_index "votes", ["target_type"], :name => "index_votes_on_target_type"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
