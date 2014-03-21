require 'httparty'

require_relative "tumblr_question"

class TumblrAsks
  attr_accessor :username, :name, :blog_url, :no_of_asks

  # Consumer key can be used as an API key
  CONSUMER_KEY = ENV['TUMBLR_CONSUMER_KEY'] || YAML.load_file("config/tumblr_config.yaml")["consumer_key"]

  # Tumblr API returns at most 20 posts per call
  PAGE_LENGTH = 20

  def initialize(username)
    @username = username
  end

  def questions(page_start = 1)
    @questions ||= retrieve_asks(page_start)
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

  # Makes a call to the Tumblr API to retrieve asks data
  def retrieve_asks(page_start)

    # offset API param is the post number to start at (from  0) so remember to subtract page_length
    # to ensure page 1 returns posts from post number 0
    offset = calc_offset(page_start)

    response = HTTParty.get("http://api.tumblr.com/v2/blog/#{base_hostname()}/posts/answer?api_key=#{CONSUMER_KEY}&offset=#{offset}&filter=text")

    # The API returns a 404 status if the user is not found, so check for this
    # and return false if so
    if response["meta"]["status"] == 404
      return false
    else
      question_list = []

      response["response"]["posts"].each do |post|
        question_list << TumblrQuestion.new(post)
      end

      @name = response["response"]["blog"]["name"]
      @blog_url = response["response"]["blog"]["url"]
      @no_of_asks = response["response"]["total_posts"]

      return question_list
    end
  end

  def calc_offset(page_start)
    page_start == 1 ? 0 : (page_start * PAGE_LENGTH - PAGE_LENGTH)
  end

  # Each blog has a unique hostname, which can be standard or custom
  # Standard: blog shortname + tumblr.com e.g. david.tumblr.com
  # Custom: the custom domain name e.g davidslog.com
  # This method forms the correct base hostname
  def base_hostname
    @username.match(/.com/) ? @username : "#{@username}.tumblr.com"
  end
end