class MoneyTransfers::ToUser
  def self.call(sender_account_id, receiver_account_id, amount)
    sender_account = Account.find(sender_account_id)
    receiver_account = Account.find(receiver_account_id)

    ActiveRecord::Base.transaction do
      sender_account.update!(current_balance: sender_account.current_balance - amount)
      receiver_account.update!(current_balance: receiver_account.current_balance + amount)
      MoneyTransfer.create!(sender_id: sender_account_id, receiver_id: receiver_account_id, amount:)
    end
  end
end
