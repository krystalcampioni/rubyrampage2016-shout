class ReactionsController < ApplicationController
  def create
    reaction = shout.reactions.find_or_create_by(emoji: reaction_params[:emoji])
    reaction.increment!(:counter)
  end

  private

  def shout
    @shout ||= Shout.find(params[:shout_id])
  end

  def reaction_params
    params.require(:reaction).permit(:emoji)
  end
end
