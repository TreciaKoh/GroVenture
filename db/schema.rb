# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140721054118) do

  create_table "appendixes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "supportdoc_file_name"
    t.string   "supportdoc_content_type"
    t.integer  "supportdoc_file_size"
    t.datetime "supportdoc_updated_at"
  end

  create_table "educations", force: true do |t|
    t.integer  "staff_id"
    t.string   "schoolname"
    t.string   "schooladdress"
    t.string   "level"
    t.integer  "from"
    t.integer  "to"
    t.boolean  "didyougraduate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employment_histories", force: true do |t|
    t.integer  "staff_id"
    t.string   "employername"
    t.string   "employeraddress"
    t.string   "position"
    t.integer  "from"
    t.integer  "to"
    t.integer  "salary"
    t.string   "reasonforleaving"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employment_histories", ["staff_id"], name: "index_employment_histories_on_staff_id", using: :btree

  create_table "follow_ups", force: true do |t|
    t.integer  "recordId"
    t.datetime "dateFollowUp"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaves", force: true do |t|
    t.string   "staffid"
    t.string   "company"
    t.string   "profession"
    t.date     "datestart"
    t.date     "dateend"
    t.decimal  "total",      precision: 5, scale: 2
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "approved"
    t.string   "leavetype"
    t.string   "staff_id"
    t.string   "starttime"
    t.string   "endtime"
  end

  add_index "leaves", ["staff_id"], name: "index_leaves_on_staff_id", using: :btree

  create_table "letters", force: true do |t|
    t.string   "name"
    t.text     "text",       limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "login_logs", force: true do |t|
    t.string   "userid"
    t.datetime "logintime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "supportdoc_file_name"
    t.string   "supportdoc_content_type"
    t.integer  "supportdoc_file_size"
    t.datetime "supportdoc_updated_at"
  end

  create_table "main_record_gros", force: true do |t|
    t.integer  "recordId"
    t.string   "companyName"
    t.string   "address"
    t.string   "postalCode"
    t.string   "contactPerson"
    t.string   "position"
    t.string   "hp"
    t.string   "office"
    t.string   "email"
    t.string   "apptBy"
    t.datetime "dateAppt"
    t.string   "remarks"
    t.string   "attendedBy"
    t.string   "attendedByGrade"
    t.string   "attendedByRemarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",            default: false
  end

  create_table "main_records", force: true do |t|
    t.integer  "recordId"
    t.string   "companyName"
    t.string   "address"
    t.string   "postalCode"
    t.string   "contactPerson"
    t.string   "position"
    t.string   "hp"
    t.string   "office"
    t.string   "email"
    t.string   "apptBy"
    t.datetime "dateAppt"
    t.string   "remarks"
    t.string   "attendedBy"
    t.string   "attendedByGrade"
    t.string   "attendedByRemarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed",            default: false
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.integer  "numtiers"
    t.integer  "nummonths"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffpays", force: true do |t|
    t.integer  "staffid"
    t.decimal  "basic",       precision: 10, scale: 2
    t.decimal  "attendance",  precision: 10, scale: 2
    t.decimal  "performance", precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "commission",  precision: 10, scale: 2
    t.decimal  "deduction",   precision: 10, scale: 2
    t.decimal  "employerCpf", precision: 10, scale: 2
    t.decimal  "employeeCpf", precision: 10, scale: 2
  end

  create_table "staffs", force: true do |t|
    t.string   "positionapplied"
    t.string   "salutation"
    t.string   "fullname"
    t.string   "address"
    t.integer  "telephone"
    t.date     "dob"
    t.string   "birthplace"
    t.string   "race"
    t.string   "dialect"
    t.string   "nric"
    t.string   "colour"
    t.string   "citizenship"
    t.string   "sex"
    t.string   "religion"
    t.string   "incometaxno"
    t.string   "drivinglicenseno"
    t.string   "maritalstatus"
    t.string   "spousename"
    t.string   "spouseoccupation"
    t.integer  "noofchildren"
    t.string   "agerange"
    t.string   "emergencyname"
    t.string   "emergencyrelationship"
    t.string   "emergencyaddress"
    t.integer  "emergencytelephone"
    t.boolean  "servingbond"
    t.integer  "salaryexpected"
    t.date     "dateavailable"
    t.boolean  "previousapplied"
    t.date     "previousdate"
    t.string   "previousposition"
    t.string   "languagespoken"
    t.string   "languagewritten"
    t.string   "physicaldisability"
    t.string   "majorillness"
    t.string   "staffid"
    t.string   "password"
    t.string   "profession"
    t.string   "company"
    t.date     "dateemployed"
    t.date     "dobchild"
    t.string   "department"
    t.integer  "tier"
    t.decimal  "overwrittenleave",      precision: 5, scale: 2
    t.date     "overwrittenon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remarks"
  end

  create_table "telemarketers", force: true do |t|
    t.string   "teleid"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telepays", force: true do |t|
    t.integer  "teleid"
    t.decimal  "basic",       precision: 10, scale: 2
    t.decimal  "cpf",         precision: 10, scale: 2
    t.decimal  "attendance",  precision: 10, scale: 2
    t.decimal  "performance", precision: 10, scale: 2
    t.decimal  "commission",  precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
