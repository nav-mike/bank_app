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

# for ui
user = Users::Create.call email: 'm.navrotskiy@gmail.com', password: '12345678', password_confirmation: '12345678'
other_user = Users::Create.call email: 'mikhail.navrotskii@gmail.com', password: '12345678', password_confirmation: '12345678'
MoneyTransfers::GiveCreditToUser.call(user.accounts.first&.id, 1_000)
MoneyTransfers::GiveCreditToUser.call(other_user.accounts.first&.id, 1_000)

2.times { MoneyTransfers::ToUser.call(other_user.accounts.first&.id, user.accounts.first&.id, [100, 200].sample) }
MoneyTransfers::ToUser.call(user.accounts.first&.id, other_user.accounts.first&.id, 50)
