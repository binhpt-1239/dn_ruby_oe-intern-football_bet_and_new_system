# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_21_085321) do

  create_table "bets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "soccer_match_id", null: false
    t.float "rate"
    t.integer "bet_type"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soccer_match_id"], name: "index_bets_on_soccer_match_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "news_id"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["news_id"], name: "index_comments_on_news_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "currencies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.float "amount"
    t.bigint "user_id", null: false
    t.bigint "currency_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_type_id"], name: "index_currencies_on_currency_type_id"
    t.index ["user_id"], name: "index_currencies_on_user_id"
  end

  create_table "currency_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
  end

  create_table "goal_results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "player_id"
    t.datetime "time_goal"
    t.bigint "soccer_match_id"
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_goal_results_on_player_id"
    t.index ["soccer_match_id"], name: "index_goal_results_on_soccer_match_id"
    t.index ["team_id"], name: "index_goal_results_on_team_id"
  end

  create_table "news", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "player_infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "team_tournament_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_player_infos_on_player_id"
    t.index ["team_tournament_id"], name: "index_player_infos_on_team_tournament_id"
  end

  create_table "players", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.integer "number"
  end

  create_table "soccer_matches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "home_id"
    t.integer "guest_id"
    t.bigint "tournament_id"
    t.datetime "time"
    t.boolean "status", default: false
    t.index ["tournament_id"], name: "index_soccer_matches_on_tournament_id"
  end

  create_table "team_tournaments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "tournament_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_team_tournaments_on_team_id"
    t.index ["tournament_id"], name: "index_team_tournaments_on_tournament_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tournaments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.date "begin_time"
    t.date "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_bets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.float "amount"
    t.bigint "soccer_match_id"
    t.bigint "team_id"
    t.boolean "result_bet"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soccer_match_id"], name: "index_user_bets_on_soccer_match_id"
    t.index ["team_id"], name: "index_user_bets_on_team_id"
    t.index ["user_id"], name: "index_user_bets_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "remember_digest"
  end

  add_foreign_key "bets", "soccer_matches"
  add_foreign_key "comments", "news"
  add_foreign_key "comments", "users"
  add_foreign_key "currencies", "currency_types"
  add_foreign_key "currencies", "users"
  add_foreign_key "goal_results", "players"
  add_foreign_key "goal_results", "soccer_matches"
  add_foreign_key "goal_results", "teams"
  add_foreign_key "news", "users"
  add_foreign_key "player_infos", "players"
  add_foreign_key "player_infos", "team_tournaments"
  add_foreign_key "soccer_matches", "tournaments"
  add_foreign_key "team_tournaments", "teams"
  add_foreign_key "team_tournaments", "tournaments"
  add_foreign_key "user_bets", "soccer_matches"
  add_foreign_key "user_bets", "teams"
  add_foreign_key "user_bets", "users"
end
