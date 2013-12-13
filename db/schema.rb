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

ActiveRecord::Schema.define(version: 20131213164129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_exemplaries", force: true do |t|
    t.integer  "book_id"
    t.integer  "owner_id"
    t.boolean  "available",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_exemplaries", ["book_id"], name: "index_book_exemplaries_on_book_id", using: :btree
  add_index "book_exemplaries", ["owner_id"], name: "index_book_exemplaries_on_owner_id", using: :btree

  create_table "books", force: true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.integer  "editorial_id"
    t.date     "published_date"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "editorials", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "editorials", ["name"], name: "index_editorials_on_name", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string   "account_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
