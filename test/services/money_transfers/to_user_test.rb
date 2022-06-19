require 'test_helper'

class ToUserTest < ActiveSupport::TestCase
  test 'when sender has enough money, the transfer is successful' do
    sender = Users::Create.call(email: 'sender@email.com', password: '12345678', password_confirmation: '12345678')
    sender.accounts.first.update!(current_balance: 100)

    receiver = Users::Create.call(email: 'receiver@email.com', password: '12345678', password_confirmation: '12345678')

    transfer = MoneyTransfers::ToUser.call(sender.accounts.first.id, receiver.accounts.first.id, 50)

    assert_equal 1, MoneyTransfer.count
    assert_equal 50, transfer.amount
    assert_equal 50, sender.accounts.first.current_balance
    assert_equal 50, receiver.accounts.first.current_balance
  end

  test 'when sender has not enough money, the transfer is rejected' do
    sender = Users::Create.call(email: 'sender@email.com', password: '12345678', password_confirmation: '12345678')
    sender.accounts.first.update!(current_balance: 10)

    receiver = Users::Create.call(email: 'receiver@email.com', password: '12345678', password_confirmation: '12345678')

    assert_raise(ActiveRecord::RecordInvalid) do
      MoneyTransfers::ToUser.call(sender.accounts.first.id, receiver.accounts.first.id, 50)
    end
    assert_equal 0, MoneyTransfer.count
    assert_equal 10, sender.accounts.first.current_balance
    assert_equal 0, receiver.accounts.first.current_balance
  end
end
