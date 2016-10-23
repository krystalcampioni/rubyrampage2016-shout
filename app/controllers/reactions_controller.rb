class ReactionsController < ApplicationController
  def create
    reaction = shout.reactions.create(reaction_params)
    reaction.increment(:counter)

    render json: reactions_json
  end

  private

  def shout
    @shout ||= Shout.find(params[:shout_id])
  end

  def reaction_params
    params.require(:reaction).permit(:emoji)
  end

  def reactions_json
    shout.reactions.collect do |reaction|
      { reaction.emoji => reaction.counter }
    end
  end
end
