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

ActiveRecord::Schema.define(version: 2021_11_16_040721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "merchants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_sources", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "payment_type"
    t.string "encrypted_card_number"
    t.string "encrypted_card_number_iv"
    t.string "encrypted_exp_month"
    t.string "encrypted_exp_month_iv"
    t.string "encrypted_exp_year"
    t.string "encrypted_exp_year_iv"
    t.string "encrypted_cvc"
    t.string "encrypted_cvc_iv"
    t.string "encrypted_billing_zip"
    t.string "encrypted_billing_zip_iv"
    t.string "encrypted_account_number"
    t.string "encrypted_account_number_iv"
    t.string "encrypted_routing_number"
    t.string "encrypted_routing_number_iv"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "amount"
    t.integer "fee_charged"
    t.string "state"
    t.uuid "merchant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_id"], name: "index_payouts_on_merchant_id"
  end

  create_table "routing_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "number"
    t.string "bank_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_routing_numbers_on_number"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "amount"
    t.datetime "bill_me_on"
    t.string "state", default: "created"
    t.uuid "merchant_id"
    t.uuid "payment_source_id"
    t.uuid "payout_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["merchant_id"], name: "index_transactions_on_merchant_id"
    t.index ["payment_source_id"], name: "index_transactions_on_payment_source_id"
    t.index ["payout_id"], name: "index_transactions_on_payout_id"
  end

end
