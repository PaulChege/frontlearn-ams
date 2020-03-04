# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_200_304_081_900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'assessments', force: :cascade do |t|
    t.string 'semester_month'
    t.string 'semester_year'
    t.integer 'status'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'course_units', force: :cascade do |t|
    t.bigint 'course_id'
    t.bigint 'unit_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['course_id'], name: 'index_course_units_on_course_id'
    t.index ['unit_id'], name: 'index_course_units_on_unit_id'
  end

  create_table 'courses', force: :cascade do |t|
    t.bigint 'school_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'name'
    t.integer 'level'
    t.index ['school_id'], name: 'index_courses_on_school_id'
  end

  create_table 'results', force: :cascade do |t|
    t.bigint 'unit_id'
    t.bigint 'student_id'
    t.bigint 'assessment_id'
    t.float 'attendance'
    t.float 'assignments'
    t.float 'cat_practical'
    t.float 'cat_theory'
    t.float 'final_practical'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.float 'final_theory'
    t.integer 'final_assessment'
    t.index ['assessment_id'], name: 'index_results_on_assessment_id'
    t.index ['student_id'], name: 'index_results_on_student_id'
    t.index ['unit_id'], name: 'index_results_on_unit_id'
  end

  create_table 'schools', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'students', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'admission_no'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.bigint 'course_id'
    t.string 'email'
    t.string 'mobile_number'
    t.integer 'intake_month'
    t.integer 'intake_year'
    t.index ['course_id'], name: 'index_students_on_course_id'
  end

  create_table 'units', force: :cascade do |t|
    t.string 'code'
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'full_name'
    t.integer 'role'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'course_units', 'courses'
  add_foreign_key 'course_units', 'units'
  add_foreign_key 'courses', 'schools'
  add_foreign_key 'results', 'assessments'
  add_foreign_key 'results', 'students'
  add_foreign_key 'results', 'units'
  add_foreign_key 'students', 'courses'
end
