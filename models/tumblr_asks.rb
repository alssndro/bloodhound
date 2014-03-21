require 'httparty'

require_relative "tumblr_question"

class TumblrAsks
  attr_accessor :username, :question_list, :name, :blog_url, :no_of_asks

  # Consumer key can be used as an API key
  CONSUMER_KEY = ENV['TUMBLR_CONSUMER_KEY'] || YAML.load_file("config/tumblr_config.yaml")["consumer_key"]

  # Tumblr API returns at most 20 posts per call
  PAGE_LENGTH = 20

  def initialize(username, page_start_pos = 0)
    @username = username
    @question_list = retrieve_asks(page_start_pos)
  end

  def blog_url
    "http://" + @username + ".tumblr.com"
  end

  def blog_avatar_url
    "http://api.tumblr.com/v2/blog/#{base_hostname()}/avatar/128"
  end

  def blog_url
    "http://#{base_hostname()}"
  end

  def last_page_no
    @no_of_asks.to_f % 20 == 0 ? @no_of_asks/2 % 20 : @no_of_asks/20 + 1
  end

  private

  # Make a call to the tumblr api to retrieve asks.
  def retrieve_asks(page_start_pos)

    # 'offset' is the post number to start at (from  0) so remember to subtract page_length
    # to ensure page 1 returns posts from post no 0
    response = HTTParty.get("http://api.tumblr.com/v2/blog/#{base_hostname()}/posts/answer?api_key=#{CONSUMER_KEY}&offset=#{page_start_pos * PAGE_LENGTH - PAGE_LENGTH }&filter=text")
    
    question_list = []

    response["response"]["posts"].each do |post|
      question_list << TumblrQuestion.new(post)
    end

    @name = response["response"]["blog"]["name"]
    @blog_url = response["response"]["blog"]["url"]
    @no_of_asks = response["response"]["total_posts"]

    return question_list
  end

  # Each blog has a unique hostname, which can be standard or custom
  # Standard: blog shortname + tumblr.com e.g. david.tumblr.com
  # Custom: the custom domain name e.g davidslog.com
  # This method forms the correct base hostname
  def base_hostname
    @username.match(/.com/) ? @username : "#{@username}.tumblr.com"
  end
end