class UserSessionsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]

  def new = @user_session = UserSession.new

  def create
    @user_session = UserSession.new(user_session_params.to_h)
    if @user_session.save
      redirect_to root_url
    else
      render action: :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url
  end

  private

  def user_session_params = params.require(:user_session).permit(:email, :password)
end
