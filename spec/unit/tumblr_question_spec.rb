require 'test_helper'

describe "TumblrQuestions" do
  let(:question) {
      TumblrQuestion.new({
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
        "question"=> "I thought Tumblr started in 2007, yet you have posts from 2006?",
        "answer"=> "This is the answer"
      })
    }

  it "has a formatted ask date" do
    expect(question.asked_on).to eq("Jul 11 2011")
  end

  it "has an associated answer" do
    expect(question.answer).to eq("This is the answer")
  end

  it "has the original question" do
    expect(question.question).to eq("I thought Tumblr started in 2007, yet you have posts from 2006?")
  end

  it "has the URL of the original question" do
    expect(question.question_url).to eq("http://www.davidslog.com/7504154594")
  end
end