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

ActiveRecord::Schema.define(:version => 20120205225533) do

  create_table "folders", :force => true do |t|
    t.integer  "parent_id"
    t.string   "basename"
    t.string   "pathname"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "children_count",  :default => 0
    t.integer  "templates_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", :force => true do |t|
    t.integer  "folder_id"
    t.string   "pathname"
    t.string   "basename"
    t.text     "body"
    t.string   "locale"
    t.string   "format"
    t.string   "handler"
    t.boolean  "partial",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
