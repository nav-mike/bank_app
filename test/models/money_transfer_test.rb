require "test_helper"

class MoneyTransferTest < ActiveSupport::TestCase
  test 'does not save money transfer with non positive amount' do
    user_1 = User.create! email: 'some@email.com', password: '12345678', password_confirmation: '12345678'
    account_1 = Account.create!(current_balance: 100, user: user_1)

    user_2 = User.create! email: 'some2@email.com', password: '12345678', password_confirmation: '12345678'
    account_2 = Account.create!(current_balance: 100, user: user_2)

    money_transfer = MoneyTransfer.new(amount: 0, sender: account_1, receiver: account_2)
    assert_not money_transfer.save
  end
end
