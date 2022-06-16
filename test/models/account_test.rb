require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test 'does not save account with negative current balance' do
    user = User.create! email: 'some@email.com', password: '12345678', password_confirmation: '12345678'
    account = Account.new(current_balance: -1, user:)

    assert_not account.save
  end
end
