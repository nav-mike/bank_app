class MoneyTransfer < ApplicationRecord
  belongs_to :sender, class_name: 'Account'
  belongs_to :receiver, class_name: 'Account'

  validates :amount, numericality: { greater_than: 0 }
end
