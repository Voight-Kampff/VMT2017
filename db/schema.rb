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

ActiveRecord::Schema.define(version: 20190822155107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "concerts", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.datetime "date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "image"
    t.boolean  "unnumbered"
    t.string   "subline"
    t.string   "footnote"
    t.integer  "location_id"
    t.boolean  "live",        default: false
  end

  create_table "concerts_reservation_types", id: false, force: :cascade do |t|
    t.integer "reservation_type_id"
    t.integer "concert_id"
    t.index ["concert_id"], name: "index_concerts_reservation_types_on_concert_id", using: :btree
    t.index ["reservation_type_id"], name: "index_concerts_reservation_types_on_reservation_type_id", using: :btree
  end

  create_table "contact_tags", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_tags_on_contact_id", using: :btree
    t.index ["tag_id"], name: "index_contact_tags_on_tag_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "telephone"
    t.string   "number"
    t.string   "road"
    t.string   "town"
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "title"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "road"
    t.string   "postcode"
    t.string   "town"
    t.string   "country"
    t.string   "email"
    t.string   "telephone"
    t.integer  "free_tickets"
    t.integer  "order_id"
    t.string   "slug"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "used"
    t.integer  "reservation_type_id"
    t.integer  "concert_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "preposition"
    t.string   "address"
    t.string   "access"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "road"
    t.integer  "postcode"
    t.string   "town"
    t.string   "country"
    t.binary   "issued"
    t.integer  "total"
    t.string   "email"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
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
    t.string   "stripe_token"
    t.integer  "user_id"
    t.boolean  "processing",   default: false
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

  create_table "scans", force: :cascade do |t|
    t.integer  "reservation_id"
    t.integer  "scanner_user_id"
    t.boolean  "status"
    t.string   "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "seat_codes", force: :cascade do |t|
    t.integer  "seat_id"
    t.string   "row"
    t.integer  "column"
    t.string   "code"
    t.string   "concert_name"
    t.string   "concert_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "seats", force: :cascade do |t|
    t.string   "row"
    t.integer  "column"
    t.integer  "price"
    t.integer  "concert_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "admin"
    t.boolean  "cashier"
    t.boolean  "viewer"
    t.boolean  "checker"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "telephone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
