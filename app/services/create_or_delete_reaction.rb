class CreateOrDeleteReaction
  attr_reader :shout, :emoji, :emojis_from_user
  def initialize(shout, emoji, emojis_from_cookie)
    @shout = shout
    @emoji = Gemojione::Index.new.find_by_moji(emoji)
    @emojis_from_user = (emojis_from_cookie || '').split(',')
  end

  def run
    reaction = shout.reactions.find_or_create_by(emoji: emoji['moji'])
    if existent_reaction_by_user?
      reaction.decrement!(:counter)
    else
      reaction.increment!(:counter)
    end
    reaction.destroy if reaction.counter.zero?
  end

  def emojis_to_store
    if existent_reaction_by_user?
      emojis_from_user - [emoji['name']]
    else
      emojis_from_user + [emoji['name']]
    end.sort.join(',')
  end

  def existent_reaction_by_user?
    emojis_from_user.include?(emoji['name'])
  end
end
