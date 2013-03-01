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

ActiveRecord::Schema.define(:version => 20130215115340) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "owner_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "parent_id"
    t.integer  "organization_id"
  end

  create_table "events", :force => true do |t|
    t.string   "type"
    t.integer  "actor_id"
    t.string   "actor_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.string   "action"
    t.string   "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["target_id"], :name => "index_events_on_target_id"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.integer  "value"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "feedbacks", ["task_id"], :name => "index_feedbacks_on_task_id"
  add_index "feedbacks", ["user_id"], :name => "index_feedbacks_on_user_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "dialog_id"
    t.text     "body"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "messages", ["dialog_id", "receiver_id"], :name => "index_messages_on_dialog_id_and_receiver_id"
  add_index "messages", ["dialog_id", "sender_id"], :name => "index_messages_on_dialog_id_and_sender_id"
  add_index "messages", ["sender_id"], :name => "messages_sender_id_with_id_eq_dialog_idx"

  create_table "organizations", :force => true do |t|
    t.integer  "user_id"
    t.string   "slug"
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.string   "skype"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "logo"
    t.text     "about"
    t.boolean  "verified",   :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "address"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug"

  create_table "preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "preferenceble_id"
    t.string   "preferenceble_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "prize_types", :force => true do |t|
    t.string   "name"
    t.boolean  "segregate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.boolean  "is_free"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "task_prizes", :force => true do |t|
    t.integer "task_id"
    t.integer "prize_type_id"
    t.integer "count"
  end

  add_index "task_prizes", ["task_id"], :name => "index_task_prizes_on_task_id"

  create_table "task_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title"
    t.text     "problem"
    t.text     "solution"
    t.datetime "deadline"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "state"
    t.integer  "task_type_id"
    t.integer  "prize_id"
    t.string   "location"
    t.string   "image"
    t.string   "file"
    t.integer  "owner_id"
    t.integer  "organization_id"
    t.boolean  "is_free"
  end

  create_table "users", :force => true do |t|
    t.string        "email",                  :default => "", :null => false
    t.string        "encrypted_password",     :default => "", :null => false
    t.string        "reset_password_token"
    t.datetime      "reset_password_sent_at"
    t.datetime      "remember_created_at"
    t.integer       "sign_in_count",          :default => 0
    t.datetime      "current_sign_in_at"
    t.datetime      "last_sign_in_at"
    t.string        "current_sign_in_ip"
    t.string        "last_sign_in_ip"
    t.string        "first_name"
    t.string        "last_name"
    t.text          "about"
    t.string        "avatar"
    t.string        "website"
    t.string        "skype"
    t.string        "twitter"
    t.string        "facebook"
    t.string        "linkedin"
    t.datetime      "created_at",                             :null => false
    t.datetime      "updated_at",                             :null => false
    t.integer       "rating",                 :default => 0,  :null => false
    t.string        "confirmation_token"
    t.datetime      "confirmed_at"
    t.datetime      "confirmation_sent_at"
    t.string        "unconfirmed_email"
    t.integer_array "ignored_users_ids"
    t.string        "city"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
