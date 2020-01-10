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

ActiveRecord::Schema.define(version: 2020_01_10_204948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "properties", force: :cascade do |t|
    t.integer "property_type", default: 0
    t.integer "marketing_type", default: 0
    t.decimal "lng", precision: 32, scale: 16, default: "0.0", null: false
    t.decimal "lat", precision: 32, scale: 16, default: "0.0", null: false
    t.string "house_number"
    t.string "street"
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geometry "geospatial_geometry", limit: {:srid=>0, :type=>"geometry"}
    t.index ["geospatial_geometry"], name: "properties_geospatial_geometry", using: :gist
  end

end
