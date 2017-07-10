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

ActiveRecord::Schema.define(version: 20170710153913) do

  create_table "concerts", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "date"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image"
    t.boolean  "unnumbered"
    t.string   "subline"
    t.string   "footnote"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "road"
    t.integer  "postcode"
    t.string   "town"
    t.string   "country"
    t.binary   "issued"
    t.integer  "total"
    t.integer  "stripe_id"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "payment_type"
    t.boolean  "paid"
    t.boolean  "held"
    t.string   "hold_type"
    t.string   "code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "telephone"
    t.string   "title"
    t.text     "notes"
    t.boolean  "flagged"
  end

  create_table "reservation_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "public"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "price"
    t.integer  "seat_id"
    t.string   "type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "reservation_type_id"
    t.string   "code"
    t.boolean  "scanned"
  end

  create_table "seats", force: :cascade do |t|
    t.string   "row"
    t.integer  "column"
    t.integer  "price"
    t.integer  "concert_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
