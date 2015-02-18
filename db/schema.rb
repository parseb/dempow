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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150127152436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"

  create_table "comments", force: true do |t|
    t.string   "ctitle"
    t.string   "cbody"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "initiative_id"
  end

  add_index "comments", ["initiative_id"], name: "index_comments_on_initiative_id", using: :btree
  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "counties", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delegations", force: true do |t|
    t.integer  "user_id"
    t.integer  "initiative_id"
    t.integer  "to"
    t.integer  "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "initiatives", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deadline"
    t.string   "status"
    t.string   "locality"
    t.string   "county"
    t.string   "scope"
  end

  add_index "initiatives", ["user_id"], name: "index_initiatives_on_user_id", using: :btree

  create_table "localities", force: true do |t|
    t.integer  "county_id"
    t.string   "name"
    t.integer  "siruta"
    t.decimal  "latitude",   precision: 18, scale: 16
    t.decimal  "longitude",  precision: 18, scale: 16
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "localities", ["county_id"], name: "index_localities_on_county_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "value",      default: 0
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "post_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "ratings", ["comment_id"], name: "index_ratings_on_comment_id", using: :btree
  add_index "ratings", ["post_id"], name: "index_ratings_on_post_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true, using: :btree
  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "activated",              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "declaration"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "locality"
    t.string   "county"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer  "initiative_id"
    t.integer  "user_id"
    t.string   "vtype"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["initiative_id"], name: "index_votes_on_initiative_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
