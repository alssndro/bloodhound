require 'test_helper'

class TumblrAsksTest < MiniTest::Test
    
  def setup
    
  end

  def test_asks_contains_a_list_of_questions_when_available
    asks = TumblrAsks.new('davidslog.com')
    refute_equal 0, asks.question_list.length
  end

  def test_question_list_contains_tumblr_question_objects
    asks = TumblrAsks.new('davidslog.com')

    asks.question_list.each do |q|
      assert_instance_of TumblrQuestion, q
    end
  end
end