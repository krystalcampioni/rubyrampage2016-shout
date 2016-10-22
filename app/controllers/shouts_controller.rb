class ShoutsController < ApplicationController
  before_action :authenticate_user!, only: [:me]

  def index
    @user = User.find(params[:user_id])
    @shouts = @user.shouts
  end

  def me
    @user = current_user
    @shouts = @user.shouts
    @sent_shouts = @user.sent_shouts
    @shout = Shout.new(shouter: @user)
  end
end
