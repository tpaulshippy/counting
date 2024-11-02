# frozen_string_literal: true

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

ActiveRecord::Schema[7.1].define(version: 20_240_608_201_901) do
  create_table 'counters', force: :cascade do |t|
    t.string 'name'
    t.integer 'number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.index ['user_id'], name: 'index_counters_on_user_id'
  end

  create_table 'counters_users', id: false, force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'counter_id', null: false
  end

  create_table 'histories', force: :cascade do |t|
    t.integer 'counter_id', null: false
    t.integer 'change'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'created_by'
    t.string 'comment'
    t.index ['counter_id'], name: 'index_histories_on_counter_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'provider'
    t.string 'uid'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'counters', 'users'
  add_foreign_key 'histories', 'counters'
  add_foreign_key 'histories', 'users', column: 'created_by'
end
