class Users::Create
  def self.call(email:, password:, password_confirmation:)
    user = User.create!(email:, password:, password_confirmation:)
    user.accounts.create!(current_balance: 0)
    user
  end
end
