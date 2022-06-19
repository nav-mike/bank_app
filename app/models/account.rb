class Account < ApplicationRecord
  include Statusable

  belongs_to :user

  validates :current_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :sent_money_transfers, class_name: 'MoneyTransfer', dependent: :destroy, foreign_key: :sender_id
  has_many :received_money_transfers, class_name: 'MoneyTransfer', dependent: :destroy, foreign_key: :receiver_id

  scope :bank_accounts, -> { where(user: User.bank) }
end
