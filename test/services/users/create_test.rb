require 'test_helper'

class CreateTest < ActiveSupport::TestCase
  test 'creates a user with one account with zero balance' do
    user = Users::Create.call(email: 'some@email.com', password: '12345678', password_confirmation: '12345678')

    assert_equal 1, User.count
    assert_equal 1, user.accounts.count
    assert_equal 0, user.accounts.first.current_balance
  end
end
