class User < ApplicationRecord
  act_as_authentic

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: 'should look like an email address.' },
                    length: { maximum: 100 }

  validates :password, confirmation: { if: :require_password? }, length: { minimum: 8, if: :require_password? }
  validates :password_confirmation, length: { minimum: 8, if: :require_password? }
end
