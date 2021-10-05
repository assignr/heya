# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_14_174703) do

  create_table "contacts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email"
    t.json "traits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heya_campaign_memberships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.string "campaign_gid", null: false
    t.string "step_gid", null: false
    t.boolean "concurrent", default: false, null: false
    t.datetime "last_sent_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_type", "user_id", "campaign_gid"], name: "user_campaign_idx", unique: true
  end

  create_table "heya_campaign_receipts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.string "step_gid", null: false
    t.datetime "sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_type", "user_id", "step_gid"], name: "user_step_idx", unique: true
  end

end
