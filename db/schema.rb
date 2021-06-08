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

ActiveRecord::Schema.define(version: 20160625155926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
    t.text "score_ids", default: [], array: true
    t.integer "total_money_bet", default: 0
    t.integer "total_money_win", default: 0
    t.boolean "locked", default: false
    t.datetime "last_changed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "games", force: :cascade do |t|
    t.integer "round_id"
    t.integer "group_id"
    t.integer "pos"
    t.integer "team1_id"
    t.integer "team2_id"
    t.string "unknown_team1_title_vi"
    t.string "unknown_team2_title_vi"
    t.datetime "play_at"
    t.integer "score1"
    t.integer "score2"
    t.integer "score_id"
    t.integer "winner"
    t.boolean "locked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_reported", default: false
    t.string "reason"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.string "title_vi"
    t.integer "pos"
  end

  create_table "investments", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "total", default: 0
    t.integer "remaining", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "predict_champions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "team_id"
    t.integer "money", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "title"
    t.string "title_vi"
    t.integer "pos"
    t.integer "money_rate", default: 0
    t.date "start_at"
    t.date "end_at"
    t.boolean "is_group_stage", default: true
  end

  create_table "scores", force: :cascade do |t|
    t.string "name"
    t.integer "score1"
    t.integer "score2"
  end

  create_table "teams", force: :cascade do |t|
    t.string "key"
    t.string "title"
    t.string "title_vi"
    t.string "code"
    t.boolean "eliminated", default: false
    t.boolean "is_champion", default: false
  end

  create_table "user_alliances", force: :cascade do |t|
    t.integer "alliance_id", null: false
    t.text "user_id", default: [], array: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username"
    t.string "full_name"
    t.boolean "is_active", default: true
    t.boolean "is_alliance", default: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.boolean "is_listen_music", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

end
