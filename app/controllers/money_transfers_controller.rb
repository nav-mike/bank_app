class MoneyTransfersController < ApplicationController
  def new
    @money_transfer = MoneyTransfer.new
    @users = User.where.not(id: current_user.id).not_bank.map { [_1.email, _1.id] }
  end
end
