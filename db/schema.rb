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

ActiveRecord::Schema.define(version: 20180308153842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "summary"
    t.string "company"
    t.string "days_posted"
    t.string "location"
    t.string "link"
    t.boolean "pinned"
  end

  create_table "meetup_groups", force: :cascade do |t|
    t.string "group_url"
    t.string "name"
  end

  create_table "meetup_members", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "state"
    t.integer "country"
    t.integer "linkedin_user_id"
  end

  create_table "meetups", force: :cascade do |t|
    t.integer "utc_offset"
    t.string "event_url"
    t.string "name"
    t.integer "group_id"
    t.string "description"
    t.integer "yes_rsvp_count"
    t.string "venue_name"
    t.string "venue_city"
    t.string "venue_state"
    t.string "venue_zip"
    t.string "venue_country"
    t.string "venue_address_1"
    t.string "status"
    t.bigint "time"
    t.boolean "pinned"
  end

end
