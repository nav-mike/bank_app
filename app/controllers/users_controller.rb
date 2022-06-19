class UsersController < ApplicationController
  def show
    @user = User.includes(:accounts).find(current_user.id)
    @incomes = MoneyTransfer.where(receiver: @user.accounts).includes(sender: :user).order(created_at: :desc)
    @outcomes = MoneyTransfer.where(sender: @user.accounts).includes(receiver: :user).order(created_at: :desc)
  end
end
