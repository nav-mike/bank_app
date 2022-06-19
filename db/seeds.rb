# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

bank = User.where(email: Rails.configuration.x.bank_email).first_or_create! do |user|
  user.password = '12345678'
  user.password_confirmation = '12345678'
end

bank.accounts.create!(current_balance: 1_000_000_000) if bank.accounts.empty?
