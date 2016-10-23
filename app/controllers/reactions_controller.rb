class ReactionsController < ApplicationController
  def create
    emoji_symbol = Gemojione::Index.new.find_by_moji(reaction_params[:emoji])['name']
    service = CreateOrDeleteReaction.new(shout, emoji, cookies["shout-#{shout.id}"])
    current_reactions = (cookies["shout-#{shout.id}"] || '').split(',') << emoji_symbol
    cookies["shout-#{shout.id}"] = "#{current_reactions.uniq.join(',')}"
  end

  private

  def shout
    @shout ||= Shout.find(params[:shout_id])
  end

  def reaction_params
    params.require(:reaction).permit(:emoji)
  end
end
