require 'test_helper'

class GiveCreditToUserTest < ActiveSupport::TestCase
  test 'when bank_account_id is nil and there is at least one bank account' do
    bank = Users::Create.call(email: Rails.configuration.x.bank_email, password: '12345678', password_confirmation: '12345678')
    bank.accounts.first.update!(current_balance: 100)
    user = Users::Create.call(email: 'some@email.com', password: '12345678', password_confirmation: '12345678')

    MoneyTransfers::GiveCreditToUser.call(user.accounts.first.id, 50)

    assert_equal 1, MoneyTransfer.count
  end

  test 'when bank_account_id is nil and there is no at least one bank account' do
    User.create!(email: Rails.configuration.x.bank_email, password: '12345678', password_confirmation: '12345678')
    user = Users::Create.call(email: 'some@email.com', password: '12345678', password_confirmation: '12345678')

    assert_raise(ActiveRecord::RecordNotFound) do
      MoneyTransfers::GiveCreditToUser.call(user.accounts.first.id, 50)
    end
    assert_equal 0, MoneyTransfer.count
  end

  test 'when bank_account_id is not nil' do
    bank = Users::Create.call(email: Rails.configuration.x.bank_email, password: '12345678', password_confirmation: '12345678')
    bank.accounts.first.update!(current_balance: 100)
    user = Users::Create.call(email: 'some@email.com', password: '12345678', password_confirmation: '12345678')

    MoneyTransfers::GiveCreditToUser.call(user.accounts.first.id, 50, bank.accounts.first.id)

    assert_equal 1, MoneyTransfer.count
  end
end
