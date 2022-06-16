class Account < ApplicationRecord
  belongs_to :user

  validates :current_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
