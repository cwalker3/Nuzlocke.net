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

ActiveRecord::Schema[8.0].define(version: 2025_05_23_215613) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "area_pokemon", force: :cascade do |t|
    t.string "encounter_method", null: false
    t.integer "encounter_rate"
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id", null: false
    t.index ["area_id"], name: "index_area_pokemon_on_area_id"
    t.index ["pokemon_id"], name: "index_area_pokemon_on_pokemon_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.index ["game_id", "name"], name: "index_areas_on_game_id_and_name", unique: true
    t.index ["game_id"], name: "index_areas_on_game_id"
  end

  create_table "attempt_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "attempt_id", null: false
    t.index ["attempt_id", "item_id"], name: "index_attempt_items_on_attempt_id_and_item_id", unique: true
    t.index ["attempt_id"], name: "index_attempt_items_on_attempt_id"
    t.index ["item_id"], name: "index_attempt_items_on_item_id"
  end

  create_table "attempt_pokemon", force: :cascade do |t|
    t.integer "nature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.integer "hp_iv"
    t.integer "status"
    t.bigint "pokemon_id", null: false
    t.integer "attack_iv"
    t.integer "defense_iv"
    t.integer "special_attack_iv"
    t.integer "special_defense_iv"
    t.integer "speed_iv"
    t.bigint "attempt_id", null: false
    t.string "gender", limit: 1
    t.index ["attempt_id"], name: "index_attempt_pokemon_on_attempt_id"
    t.index ["pokemon_id"], name: "index_attempt_pokemon_on_pokemon_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.bigint "nuzlocke_id", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nuzlocke_id"], name: "index_attempts_on_nuzlocke_id"
  end

  create_table "defeated_trainers", force: :cascade do |t|
    t.bigint "attempt_id", null: false
    t.bigint "trainer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id", "trainer_id"], name: "index_defeated_trainers_on_attempt_id_and_trainer_id", unique: true
    t.index ["attempt_id"], name: "index_defeated_trainers_on_attempt_id"
    t.index ["trainer_id"], name: "index_defeated_trainers_on_trainer_id"
  end

  create_table "game_items", force: :cascade do |t|
    t.bigint "split_id", null: false
    t.string "source"
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id", null: false
    t.integer "quantity"
    t.bigint "item_id", null: false
    t.index ["area_id"], name: "index_game_items_on_area_id"
    t.index ["game_id"], name: "index_game_items_on_game_id"
    t.index ["item_id"], name: "index_game_items_on_item_id"
    t.index ["split_id"], name: "index_game_items_on_split_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_attempts", default: 0, null: false
    t.integer "active_attempts", default: 0, null: false
    t.integer "completed_attempts", default: 0, null: false
    t.index ["title"], name: "index_games_on_title", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_items_on_name", unique: true
  end

  create_table "kill_events", force: :cascade do |t|
    t.bigint "trainer_pokemon_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "attempt_pokemon_id"
    t.index ["attempt_pokemon_id"], name: "index_kill_events_on_attempt_pokemon_id"
    t.index ["trainer_pokemon_id"], name: "index_kill_events_on_trainer_pokemon_id"
  end

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "natures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nuzlocke_rules", force: :cascade do |t|
    t.bigint "nuzlocke_id", null: false
    t.bigint "rule_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nuzlocke_id", "rule_id"], name: "index_nuzlocke_rules_on_nuzlocke_id_and_rule_id", unique: true
    t.index ["nuzlocke_id"], name: "index_nuzlocke_rules_on_nuzlocke_id"
    t.index ["rule_id"], name: "index_nuzlocke_rules_on_rule_id"
  end

  create_table "nuzlockes", force: :cascade do |t|
    t.string "status", null: false
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["game_id"], name: "index_nuzlockes_on_game_id"
    t.index ["user_id"], name: "index_nuzlockes_on_user_id"
  end

  create_table "participation_events", force: :cascade do |t|
    t.bigint "trainer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "attempt_pokemon_id"
    t.index ["attempt_pokemon_id"], name: "index_participation_events_on_attempt_pokemon_id"
    t.index ["trainer_id"], name: "index_participation_events_on_trainer_id"
  end

  create_table "pokemon", force: :cascade do |t|
    t.string "species", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species"], name: "index_pokemon_on_species", unique: true
  end

  create_table "rules", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["name"], name: "index_rules_on_name", unique: true
  end

  create_table "splits", force: :cascade do |t|
    t.string "name", null: false
    t.integer "level_cap", null: false
    t.bigint "game_id", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id", "number"], name: "index_splits_on_game_id_and_number", unique: true
    t.index ["game_id"], name: "index_splits_on_game_id"
  end

  create_table "trainer_pokemon", force: :cascade do |t|
    t.bigint "trainer_id", null: false
    t.integer "hp_iv"
    t.integer "attack_iv"
    t.integer "defense_iv"
    t.integer "special_attack_iv"
    t.integer "special_defense_iv"
    t.integer "speed_iv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pokemon_id", null: false
    t.string "gender", limit: 1
    t.integer "level", null: false
    t.bigint "item_id"
    t.integer "position", null: false
    t.bigint "ability_id"
    t.bigint "move1_id"
    t.bigint "move2_id"
    t.bigint "move3_id"
    t.bigint "move4_id"
    t.bigint "nature_id"
    t.index ["ability_id"], name: "index_trainer_pokemon_on_ability_id"
    t.index ["item_id"], name: "index_trainer_pokemon_on_item_id"
    t.index ["move1_id"], name: "index_trainer_pokemon_on_move1_id"
    t.index ["move2_id"], name: "index_trainer_pokemon_on_move2_id"
    t.index ["move3_id"], name: "index_trainer_pokemon_on_move3_id"
    t.index ["move4_id"], name: "index_trainer_pokemon_on_move4_id"
    t.index ["nature_id"], name: "index_trainer_pokemon_on_nature_id"
    t.index ["pokemon_id"], name: "index_trainer_pokemon_on_pokemon_id"
    t.index ["trainer_id"], name: "index_trainer_pokemon_on_trainer_id"
  end

  create_table "trainers", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "area_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notes"
    t.string "reward"
    t.integer "trainer_type"
    t.integer "position", null: false
    t.index ["area_id"], name: "index_trainers_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "uid"
    t.string "provider"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "token_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "area_pokemon", "areas"
  add_foreign_key "area_pokemon", "pokemon"
  add_foreign_key "areas", "games"
  add_foreign_key "attempt_items", "attempts"
  add_foreign_key "attempt_items", "items"
  add_foreign_key "attempt_pokemon", "attempts"
  add_foreign_key "attempt_pokemon", "pokemon"
  add_foreign_key "attempts", "nuzlockes"
  add_foreign_key "defeated_trainers", "attempts"
  add_foreign_key "defeated_trainers", "trainers"
  add_foreign_key "game_items", "areas"
  add_foreign_key "game_items", "games"
  add_foreign_key "game_items", "items"
  add_foreign_key "game_items", "splits"
  add_foreign_key "kill_events", "attempt_pokemon"
  add_foreign_key "kill_events", "trainer_pokemon"
  add_foreign_key "nuzlocke_rules", "nuzlockes"
  add_foreign_key "nuzlocke_rules", "rules"
  add_foreign_key "nuzlockes", "games"
  add_foreign_key "nuzlockes", "users"
  add_foreign_key "participation_events", "attempt_pokemon"
  add_foreign_key "participation_events", "trainers"
  add_foreign_key "splits", "games"
  add_foreign_key "trainer_pokemon", "abilities"
  add_foreign_key "trainer_pokemon", "items"
  add_foreign_key "trainer_pokemon", "moves", column: "move1_id"
  add_foreign_key "trainer_pokemon", "moves", column: "move2_id"
  add_foreign_key "trainer_pokemon", "moves", column: "move3_id"
  add_foreign_key "trainer_pokemon", "moves", column: "move4_id"
  add_foreign_key "trainer_pokemon", "natures"
  add_foreign_key "trainer_pokemon", "pokemon"
  add_foreign_key "trainer_pokemon", "trainers"
  add_foreign_key "trainers", "areas"
end
