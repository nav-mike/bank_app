class User < ApplicationRecord
  include Statusable

  acts_as_authentic do |c|
    c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
  end

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'should look like an email address.' },
                    length: { maximum: 100 }

  validates :password, confirmation: { if: :require_password? }, length: { minimum: 8, if: :require_password? }
  validates :password_confirmation, length: { minimum: 8, if: :require_password? }

  has_many :accounts, dependent: :destroy

  def self.bank
    find_by!(email: Rails.configuration.x.bank_email)
  end
end
