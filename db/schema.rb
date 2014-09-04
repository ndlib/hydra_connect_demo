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

ActiveRecord::Schema.define(version: 20140904194349) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "hydramata_works_attachments", id: false, force: true do |t|
    t.string   "pid",            null: false
    t.string   "work_id"
    t.string   "predicate"
    t.string   "attachment_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydramata_works_attachments", ["pid"], name: "index_hydramata_works_attachments_on_pid", unique: true
  add_index "hydramata_works_attachments", ["predicate"], name: "index_hydramata_works_attachments_on_predicate"
  add_index "hydramata_works_attachments", ["work_id"], name: "index_hydramata_works_attachments_on_work_id"

  create_table "hydramata_works_predicate_presentation_sequences", force: true do |t|
    t.integer  "predicate_set_id",      null: false
    t.integer  "predicate_id",          null: false
    t.integer  "presentation_sequence", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydramata_works_predicate_presentation_sequences", ["predicate_set_id", "predicate_id"], name: "hydramata_works_predicate_presentation_sequences_identity", unique: true
  add_index "hydramata_works_predicate_presentation_sequences", ["predicate_set_id", "presentation_sequence"], name: "hydramata_works_predicate_presentation_sequences_presentation", unique: true

  create_table "hydramata_works_predicate_sets", force: true do |t|
    t.integer  "work_type_id",               null: false
    t.string   "identity",                   null: false
    t.integer  "presentation_sequence",      null: false
    t.string   "name_for_application_usage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hydramata_works_predicate_sets", ["work_type_id", "identity"], name: "hydramata_works_predicate_set_identity", unique: true
  add_index "hydramata_works_predicate_sets", ["work_type_id", "presentation_sequence"], name: "hydramata_works_predicate_set_sequence", unique: true

  create_table "hydramata_works_predicates", force: true do |t|
    t.string   "identity",                   null: false
    t.string   "name_for_application_usage"
    t.string   "datastream_name"
    t.string   "value_coercer_name"
    t.string   "value_parser_name"
    t.string   "indexing_strategy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "validations"
    t.string   "itemprop_schema_dot_org"
  end

  add_index "hydramata_works_predicates", ["identity"], name: "index_hydramata_works_predicates_on_identity", unique: true
  add_index "hydramata_works_predicates", ["name_for_application_usage"], name: "index_hydramata_works_predicates_on_name_for_application_usage", unique: true

  create_table "hydramata_works_types", force: true do |t|
    t.string   "identity",                   null: false
    t.string   "name_for_application_usage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "itemtype_schema_dot_org"
  end

  add_index "hydramata_works_types", ["identity"], name: "index_hydramata_works_types_on_identity", unique: true
  add_index "hydramata_works_types", ["name_for_application_usage"], name: "index_hydramata_works_types_on_name_for_application_usage", unique: true

  create_table "hydramata_works_works", id: false, force: true do |t|
    t.string   "pid",                                               null: false
    t.string   "work_type",                                         null: false
    t.text     "properties", limit: 2147483647
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",      limit: 32,         default: "unknown", null: false
  end

  add_index "hydramata_works_works", ["state"], name: "index_hydramata_works_works_on_state"

end
