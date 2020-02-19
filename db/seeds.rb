# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  full_name: "First Admin", 
  email: "admin@frontlearn.co.ke",
  role: :admin,
  password: "frontlearn16" 
)

["Culinary Arts", "ICT", "Business"].each do |school|
  school = School.find_or_create_by(name: school)
end

