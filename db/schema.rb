# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100502083712) do

  create_table "bills", :force => true do |t|
    t.integer  "client_id"
    t.string   "title"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment"
    t.date     "paid_date"
    t.date     "billed_date"
    t.integer  "bill_type_id"
    t.integer  "user_id"
    t.date     "first_admonishion_date"
    t.date     "second_admonishion_date"
  end

  add_index "bills", ["bill_type_id"], :name => "index_bills_on_bill_type_id"
  add_index "bills", ["client_id"], :name => "index_bills_on_client_id"
  add_index "bills", ["user_id"], :name => "index_bills_on_user_id"

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "vorname"
    t.string   "firma"
    t.string   "strasse"
    t.string   "plz"
    t.string   "ort"
    t.string   "tel"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "clients", ["user_id"], :name => "index_clients_on_user_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "tax_no"
    t.string   "street"
    t.string   "plz"
    t.string   "city"
    t.string   "tel"
    t.string   "email"
    t.string   "web"
    t.string   "account_no"
    t.string   "bank_code"
    t.string   "bank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner"
    t.boolean  "billed_date_relevant"
    t.integer  "user_id"
    t.integer  "time_to_pay",          :default => 14
  end

  create_table "company_logos", :force => true do |t|
    t.integer  "company_id"
    t.string   "content_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_logos", ["company_id"], :name => "index_company_logos_on_company_id"

  create_table "expenditure_types", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenditures", :force => true do |t|
    t.string   "bill_id"
    t.string   "seller"
    t.string   "name"
    t.date     "billed_date"
    t.decimal  "net_total",           :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "paid_date"
    t.decimal  "tax",                 :precision => 8, :scale => 2
    t.integer  "state"
    t.integer  "expenditure_type_id"
    t.integer  "user_id"
  end

  add_index "expenditures", ["expenditure_type_id"], :name => "index_expenditures_on_expenditure_type_id"
  add_index "expenditures", ["user_id"], :name => "index_expenditures_on_user_id"

  create_table "positions", :force => true do |t|
    t.integer  "bill_id"
    t.string   "title"
    t.float    "count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.integer  "tax"
  end

  add_index "positions", ["bill_id"], :name => "index_positions_on_bill_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
