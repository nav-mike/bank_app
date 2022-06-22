class MoneyTransfersController < ApplicationController
  def new
    @money_transfer = MoneyTransfer.new
    @users = User.where.not(id: current_user.id).not_bank.map { [_1.email, _1.id] }
  end

  def create
    receiver = User.find(money_transfer_params[:receiver_id])
    MoneyTransfers::ToUser.call(current_user.accounts.first.id, receiver.accounts.first&.id, money_transfer_params[:amount].to_i)
    redirect_to root_path
  end

  def money_transfer_params = params.require(:money_transfer).permit(:amount, :receiver_id)
end
