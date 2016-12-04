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

ActiveRecord::Schema.define(version: 20161201140303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_similarities", force: :cascade do |t|
    t.integer "source_article_id", null: false
    t.integer "target_article_id", null: false
    t.float   "similarity_score"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title",        limit: 255, null: false
    t.string   "url",          limit: 255
    t.datetime "published_at"
    t.float    "sentiment_1"
    t.float    "sentiment_2"
    t.integer  "source_id",                null: false
  end

  create_table "entities", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "extracted_entities", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "entity_id",  null: false
    t.float   "score"
  end

  create_table "source_entity_sentiments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "source_similarities", force: :cascade do |t|
    t.integer "source_source_id", null: false
    t.integer "target_source_id", null: false
    t.float   "similarity_score"
  end

  create_table "sources", force: :cascade do |t|
    t.string "title", limit: 255, null: false
  end

  add_foreign_key "article_similarities", "articles", column: "source_article_id", name: "fk_source_article"
  add_foreign_key "article_similarities", "articles", column: "target_article_id", name: "fk_target_article"
  add_foreign_key "articles", "sources", name: "fk_source"
  add_foreign_key "extracted_entities", "articles", name: "fk_extracted_entity_article"
  add_foreign_key "extracted_entities", "entities", name: "fk_extracted_entity_entity"
  add_foreign_key "source_similarities", "sources", column: "source_source_id", name: "fk_source_source"
  add_foreign_key "source_similarities", "sources", column: "target_source_id", name: "fk_target_source"
end
