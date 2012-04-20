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

ActiveRecord::Schema.define(:version => 20120402084400) do

  create_table "activities", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "date"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_assigns", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answer_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.boolean  "is_vote_up", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "question_id"
    t.text     "content"
    t.integer  "vote_sum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
  end

  create_table "comments", :force => true do |t|
    t.integer  "model_id"
    t.string   "model_type"
    t.integer  "creator_id"
    t.text     "content"
    t.integer  "reply_comment_id"
    t.integer  "reply_comment_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connect_users", :force => true do |t|
    t.integer  "user_id"
    t.string   "connect_type"
    t.string   "connect_id"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.text     "account_detail"
    t.boolean  "oauth_invalid"
    t.boolean  "syn_from_connect"
    t.string   "last_syn_message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.string   "cid"
    t.string   "department"
    t.string   "location"
    t.integer  "teacher_id"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homework_assigns", :force => true do |t|
    t.integer  "creator_id"
    t.integer  "homework_id"
    t.text     "content"
    t.boolean  "is_submit",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "submitted_at"
  end

  create_table "homeworks", :force => true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media_files", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "uuid"
    t.string   "place"
    t.text     "desc"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "kind"
    t.text     "data"
    t.boolean  "is_read",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_records", :force => true do |t|
    t.integer  "user_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "online_records", ["key"], :name => "index_online_records_on_key"
  add_index "online_records", ["user_id"], :name => "index_online_records_on_user_id"

  create_table "questions", :force => true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "short_message_readings", :force => true do |t|
    t.integer  "short_message_id"
    t.integer  "user_id"
    t.integer  "contact_user_id"
    t.boolean  "is_read",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "short_messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.text     "content"
    t.boolean  "sender_read",   :default => false
    t.boolean  "receiver_read", :default => false
    t.boolean  "sender_hide",   :default => false
    t.boolean  "receiver_hide", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.text     "content"
    t.integer  "creator_id"
    t.integer  "repost_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
    t.string   "real_name",  :default => "", :null => false
    t.string   "sid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "creator_id"
    t.integer  "model_id"
    t.string   "model_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", :force => true do |t|
    t.string   "real_name",  :default => "", :null => false
    t.string   "tid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_status_links", :force => true do |t|
    t.integer  "team_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_students", :force => true do |t|
    t.integer  "team_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.string   "cid"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", :force => true do |t|
    t.integer  "creator_id"
    t.text     "content"
    t.integer  "date"
    t.boolean  "completed",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :default => "", :null => false
    t.string   "hashed_password",           :default => "", :null => false
    t.string   "salt",                      :default => "", :null => false
    t.string   "email",                     :default => "", :null => false
    t.string   "sign"
    t.string   "activation_code"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.datetime "activated_at"
    t.string   "reset_password_code"
    t.datetime "reset_password_code_until"
    t.datetime "last_login_time"
    t.boolean  "send_invite_email"
    t.integer  "reputation",                :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vote_items", :force => true do |t|
    t.integer  "vote_id"
    t.string   "item_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "vote_result_items", :force => true do |t|
    t.integer  "vote_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vote_result_id"
  end

  create_table "vote_results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "creator_id"
    t.string   "title"
    t.integer  "select_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kind",         :default => "TEXT"
  end

end