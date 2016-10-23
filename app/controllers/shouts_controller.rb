class ShoutsController < ApplicationController
  before_action :authenticate_user!, only: [:me, :create]
  before_action :fetch_user, only: [:create]

  def index
    @user = User.find_by!(nickname: params[:user_id])
    @shouts = @user.shouts
  end

  def create
    @shout = @user.sent_shouts.create!(shout_params.merge(shouter: current_user))
    redirect_to root_path
  end

  def me
    @user = current_user
    @shouts = @user.shouts
    @sent_shouts = @user.sent_shouts
    @shout = Shout.new(shouter: @user)
  end

  private

  def fetch_user
    @user = User.fetch_by_nickname(params[:user_id])
  end

  def shout_params
    params.require(:shout).permit(:message, :emoji_badge)
  end
end
