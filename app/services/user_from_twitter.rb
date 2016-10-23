class UserFromTwitter
  attr_reader :nickname
  def initialize(nickname)
    @nickname = nickname
  end

  def attributes
    twitter_info = client.user(nickname)
    {
      nickname: twitter_info.screen_name,
      name: twitter_info.name,
      profile_image_url: twitter_info.profile_image_uri.to_s
    }
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.twitter_api_key
      config.consumer_secret = Rails.application.secrets.twitter_api_secret
      config.access_token = '8618882-RX6kuoHZyonsbSTmXPfNFJiLKCKyjbHWjdbu4vCc1X'
      config.access_token_secret = 'CITxRaDVjuF03DUsmGtq7mlToT9ANAJoxUUxlynB6F3Vv'
    end
  end
end
