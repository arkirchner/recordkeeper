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

ActiveRecord::Schema[7.0].define(version: 2022_03_12_084603) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: :cascade do |t|
    t.string "coin_id", null: false
    t.float "amount", default: 0.0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id", "coin_id"], name: "index_assets_on_user_id_and_coin_id", unique: true
  end

  create_table "coins", id: :string, force: :cascade do |t|
    t.string "symbol", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ohlcs", force: :cascade do |t|
    t.decimal "open", precision: 8, scale: 2, null: false
    t.decimal "high", precision: 8, scale: 2, null: false
    t.decimal "low", precision: 8, scale: 2, null: false
    t.decimal "close", precision: 8, scale: 2, null: false
    t.string "coin_id", null: false
    t.string "source", null: false
    t.datetime "recorded_at", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id", "recorded_at"], name: "index_ohlcs_on_coin_id_and_recorded_at", unique: true
  end

  create_table "osmosis_transactions", primary_key: "tx_hash", id: :string, force: :cascade do |t|
    t.bigint "block", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "wallet_address", null: false
  end

  create_table "osmosis_wallets", primary_key: "address", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.float "amount", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["asset_id"], name: "index_transactions_on_asset_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assets", "coins"
  add_foreign_key "assets", "users"
  add_foreign_key "ohlcs", "coins"
  add_foreign_key "osmosis_transactions", "osmosis_wallets", column: "wallet_address", primary_key: "address"
  add_foreign_key "transactions", "assets"
end
