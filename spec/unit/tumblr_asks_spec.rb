require 'test_helper'

describe "TumblrAsks" do
  let(:tumblr_asks) { TumblrAsks.new('davidslog.com') }
  
  before do
    # Stub the API call, using a json file since the response body is large
    json_response = File.read(File.dirname(__FILE__) + "/../support/json_responses/tumblr_questions_page_1.json")

    stub_request(:get, /.*api\.tumblr\.com\/v2\/blog\/.*\/posts\/answer\?api_key=.*&filter=text&offset=0.*/).to_return(:status => 200, :body => json_response, :headers => {"content-type"=>["application/json; charset=utf-8"], "vary"=>["Accept-Encoding"], "p3p"=>["CP=\"ALL ADM DEV PSAi COM OUR OTRo STP IND ONL\""], "x-ua-compatible"=>["IE=Edge,chrome=1"], "transfer-encoding"=>["chunked"], "date"=>["Fri, 21 Mar 2014 17:48:47 GMT"], "connection"=>["close"]})
  end

  it "contains a list of questions when available" do
    expect(tumblr_asks.questions.length).not_to eq(0)
  end

  it "has a question list made up of TumblrQuestion objects" do
    tumblr_asks.questions.each do |question|
      expect(question.class).to eq(TumblrQuestion)
    end
  end
end