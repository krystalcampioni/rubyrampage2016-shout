class ShoutsController < ApplicationController
  before_action :authenticate_user!, only: [:me, :create]

  def index
    @user = User.find_by!(nickname: params[:user_id])
    @shouts = @user.shouts
  end

  def create
    @shout = current_user.sent_shouts.create!(shout_params)
    TwitterShout.new(@shout).create
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
