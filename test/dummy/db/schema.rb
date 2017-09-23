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

ActiveRecord::Schema.define(version: 20170917011258) do

  create_table "pokeviewer_moves", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.integer "pp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pokeviewer_moves_on_name", unique: true
  end

  create_table "pokeviewer_pokemon", force: :cascade do |t|
    t.string "uuid", limit: 191, null: false
    t.integer "species_id", null: false
    t.integer "trainer_id"
    t.string "key", limit: 191
    t.string "ot_name", null: false
    t.integer "ot_number", null: false
    t.string "met_type", null: false
    t.string "met_location"
    t.integer "met_level", null: false
    t.boolean "shiny", default: false, null: false
    t.string "nature", null: false
    t.string "gender", null: false
    t.boolean "second_ability", null: false
    t.string "unown_letter", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_pokeviewer_pokemon_on_key", unique: true
    t.index ["species_id"], name: "index_pokeviewer_pokemon_on_species_id"
    t.index ["trainer_id"], name: "index_pokeviewer_pokemon_on_trainer_id"
    t.index ["uuid"], name: "index_pokeviewer_pokemon_on_uuid", unique: true
  end

  create_table "pokeviewer_revisions", force: :cascade do |t|
    t.integer "pokemon_id", null: false
    t.integer "sequential_id", null: false
    t.string "nickname", null: false
    t.integer "experience", null: false
    t.integer "level", null: false
    t.integer "hp", null: false
    t.integer "attack", null: false
    t.integer "defense", null: false
    t.integer "special_attack", null: false
    t.integer "special_defense", null: false
    t.integer "speed", null: false
    t.integer "coolness", null: false
    t.integer "beauty", null: false
    t.integer "cuteness", null: false
    t.integer "smartness", null: false
    t.integer "toughness", null: false
    t.integer "sheen", null: false
    t.integer "hold_item"
    t.integer "move_1_id", null: false
    t.integer "move_2_id"
    t.integer "move_3_id"
    t.integer "move_4_id"
    t.integer "move_1_pp_bonuses", default: 0, null: false
    t.integer "move_2_pp_bonuses", default: 0, null: false
    t.integer "move_3_pp_bonuses", default: 0, null: false
    t.integer "move_4_pp_bonuses", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["move_1_id"], name: "index_pokeviewer_revisions_on_move_1_id"
    t.index ["move_2_id"], name: "index_pokeviewer_revisions_on_move_2_id"
    t.index ["move_3_id"], name: "index_pokeviewer_revisions_on_move_3_id"
    t.index ["move_4_id"], name: "index_pokeviewer_revisions_on_move_4_id"
    t.index ["pokemon_id", "sequential_id"], name: "index_pokeviewer_revisions_on_pokemon_id_and_sequential_id", unique: true
    t.index ["pokemon_id"], name: "index_pokeviewer_revisions_on_pokemon_id"
  end

  create_table "pokeviewer_species", force: :cascade do |t|
    t.string "name", limit: 191, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pokeviewer_species_on_name", unique: true
  end

  create_table "pokeviewer_trainers", force: :cascade do |t|
    t.string "game", null: false
    t.string "name", limit: 191, null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "number"], name: "index_pokeviewer_trainers_on_name_and_number", unique: true
  end

end
