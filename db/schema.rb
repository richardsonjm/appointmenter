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

ActiveRecord::Schema.define(version: 20160715215156) do

  create_table "ailments", force: :cascade do |t|
    t.string   "name",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "specialty_id"
  end

  add_index "ailments", ["specialty_id"], name: "index_ailments_on_specialty_id"

  create_table "appointments", force: :cascade do |t|
    t.datetime "date",       null: false
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "appointments", ["doctor_id"], name: "index_appointments_on_doctor_id"
  add_index "appointments", ["patient_id"], name: "index_appointments_on_patient_id"

  create_table "doctors", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors_specialties", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "specialty_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "doctors_specialties", ["doctor_id"], name: "index_doctors_specialties_on_doctor_id"
  add_index "doctors_specialties", ["specialty_id"], name: "index_doctors_specialties_on_specialty_id"

  create_table "patients", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients_ailments", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "ailment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "patients_ailments", ["ailment_id"], name: "index_patients_ailments_on_ailment_id"
  add_index "patients_ailments", ["patient_id"], name: "index_patients_ailments_on_patient_id"

  create_table "specialties", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
