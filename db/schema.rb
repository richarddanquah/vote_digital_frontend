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

ActiveRecord::Schema.define(version: 20200829005118) do

  create_table "awards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "merchant_id"
    t.text "description"
    t.integer "user_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "award_image_file_name"
    t.string "award_image_content_type"
    t.bigint "award_image_file_size"
    t.datetime "award_image_updated_at"
    t.string "avatar"
    t.string "avatar_url"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "award_amount", limit: 500
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "award_id"
    t.text "description"
    t.boolean "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar1"
    t.string "image1_file_name"
    t.string "image1_content_type"
    t.integer "image1_file_size"
    t.datetime "image1_updated_at"
    t.string "avatar1_url"
  end

  create_table "contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "fullname"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "merchants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.string "address"
    t.string "contact_number"
    t.string "contact_email"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nominees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.integer "category_id"
    t.text "description"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar2"
    t.integer "user_id"
    t.string "avatar2_url"
    t.string "image3_file_name"
    t.string "image3_content_type"
    t.integer "image3_file_size"
    t.datetime "image3_updated_at"
    t.string "nominee_code", limit: 500
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.boolean "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trackers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "function"
    t.integer "page"
    t.string "mob_number"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "merchant_id"
    t.string "trans_id"
    t.string "customer_number"
    t.string "customer_netowrk"
    t.string "trans_type"
    t.string "amount"
    t.string "reference"
    t.boolean "pay_status"
    t.integer "award_id"
    t.integer "category_id"
    t.integer "nominee_id"
    t.string "payment_types"
    t.string "card_name"
    t.string "card_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "techo_status", limit: 500
    t.string "techo_code", limit: 500
    t.string "techo_reason", limit: 500
    t.integer "vote_no_mm"
    t.integer "vote_no_card"
    t.integer "vote_no_card1"
    t.integer "card_number"
    t.integer "cvv_code"
    t.integer "card_month"
    t.integer "card_year"
    t.integer "voucher"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "user_name"
    t.string "first_name"
    t.string "last_name"
    t.integer "role_id"
    t.string "phone_number"
    t.boolean "status"
    t.integer "show_account_id"
    t.string "address"
    t.integer "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "ussd_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "page"
    t.boolean "msg_type"
    t.string "msisdn"
    t.string "nw_code"
    t.string "ussd_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
