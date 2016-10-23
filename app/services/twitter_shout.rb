class TwitterShout
  def initialize(shout)
    @shout = shout
  end

  def create
    return if Rails.env.test?

    @shout.users.each do |user|
      client.update(message_for_user(user))
    end
  end

  def message_for_user(user)
    shouter = @shout.shouter.nickname
    nickname = user.nickname
    app_url = "http://#{Rails.application.secrets.domain}/u/#{nickname}"
    "@#{nickname} Hey, @#{shouter_nickname} just sent you a shout at #{app_url}"
  end

  private

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.shout_twitter_api_key
      config.consumer_secret = Rails.application.secrets.shout_twitter_secret
      config.access_token = Rails.application.secrets.shout_twitter_access_key
      config.access_token_secret =  Rails.application.secrets.shout_twitter_access_secret
    end
  end
end
