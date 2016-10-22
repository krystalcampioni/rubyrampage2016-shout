class ShoutsController < ApplicationController
  before_action :authenticate_user!, only: [:me, :create]

  def index
    @user = User.find_by!(nickname: params[:user_id])
    @shouts = @user.shouts
  end

  def create
    @user = User.find_or_create_by!(nickname: params[:user_id])
    @shout = @user.shouts.create!(shout_params.merge(shouter: current_user))
    redirect_to root_path
  end

  def me
    @user = current_user
    @shouts = @user.shouts
    @sent_shouts = @user.sent_shouts
    @shout = Shout.new(shouter: @user)
  end

  private

  def shout_params
    params.require(:shout).permit(:message, :emoji_badge)
  end
end
