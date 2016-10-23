class ReactionsController < ApplicationController
  def create
    reaction = shout.reactions.first_or_create(reaction_params)
    reaction.increment(:counter)

    render json: shout.reactions_array
  end

  private

  def shout
    @shout ||= Shout.find(params[:shout_id])
  end

  def reaction_params
    params.require(:reaction).permit(:emoji)
  end
end
