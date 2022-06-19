class MoneyTransfers::GiveCreditToUser
  def self.call(user_account_id, amount, bank_account_id = nil)
    bank_account = bank_account_id.present? ? Account.bank_accounts.find(bank_account_id) : Account.bank_accounts.first!

    MoneyTransfers::ToUser.call(bank_account.id, user_account_id, amount)
  end
end
