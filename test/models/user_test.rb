require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'deletes all accounts when user is deleted' do
    user = User.create! email: 'some@email.com', password: '12345678', password_confirmation: '12345678'
    user.accounts.create(current_balance: 100, user:)

    user.destroy

    assert_equal 0, Account.count
  end
end
