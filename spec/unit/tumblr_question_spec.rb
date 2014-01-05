require 'test_helper'

class TumblrQuestionTest < MiniTest::Test
    
  def setup
    response_hash = {
            "blog_name"=> "david",
            "id"=> 7504154594,
            "post_url"=> "http://www.davidslog.com/7504154594",
            "type"=> "answer",
            "date"=> "2011-07-11 20:24:14 GMT",
            "timestamp"=> 1310415854,
            "format"=> "html",
            "reblog_key"=> "HNvqLd5G",
            "tags"=> [],
            "asking_name"=> "aperfectfacade",
            "asking_url"=> "http://aperfectfacade.tumblr.com/",
            "question"=> "I thought Tumblr started in 2007, yet you
               have posts from 2006?",
            "answer"=> "This is the answer"
    }

    @question = TumblrQuestion.new(response_hash)
  end

  def test_question_has_an_ask_date
    assert_equal "07/11/11", @question.asked_on
  end

  def test_question_hash_an_answer
    assert_equal "This is the answer", @question.answer
  end

  def test_question_hash_a_question
    assert_equal "I thought Tumblr started in 2007, yet you
               have posts from 2006?", @question.question
  end

  def test_question_has_a_url
    assert "http://www.davidslog.com/7504154594", @question.question_url
  end
end