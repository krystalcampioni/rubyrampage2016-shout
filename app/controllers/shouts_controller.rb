class ShoutsController < ApplicationController
  before_action :authenticate_user!, only: [:me, :create]

  def index
    @user = User.fetch_by_nickname(params[:user_id])
    @shouts = @user.shouts
  end

  def create
    @shout = current_user.sent_shouts.create!(shout_params)
    begin
      TwitterShout.new(@shout).create
    rescue
      nil
    end
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
