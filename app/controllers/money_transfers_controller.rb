class MoneyTransfersController < ApplicationController
  def new
    @money_transfer = MoneyTransfer.new
    @current_user_accounts = Account.for_user(current_user).map {  [_1.current_balance, _1.id] }
    @other_user_accounts = Account.for_not_user(current_user).not_bank_accounts
                                  .includes(:user).map {  ["#{_1.user.email} - #{_1.id}", _1.id] }
  end

  def create
    sender_account = current_user.accounts.find(money_transfer_params[:sender_id])
    MoneyTransfers::ToUser.call(sender_account.id, money_transfer_params[:receiver_id], money_transfer_params[:amount].to_i)
    redirect_to root_path
  end

  def money_transfer_params = params.require(:money_transfer).permit(:amount, :receiver_id, :sender_id)
end
