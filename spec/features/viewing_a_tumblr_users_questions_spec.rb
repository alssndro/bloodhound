require 'test_helper'

describe "Viewing a Tumblr user's Q&A", :type => :feature do

  context "when a valid Tumblr username is entered" do

    before do
      # Stub the API call, using a json file since the response body is large
      json_response = File.read(File.dirname(__FILE__) + "/../support/json_responses/tumblr_questions_page_1.json")

      stub_request(:get, /.*api\.tumblr\.com\/v2\/blog\/.*\/posts\/answer\?api_key=.*&filter=text&offset=0/).to_return(:status => 200, :body => json_response, :headers => {"content-type"=>["application/json; charset=utf-8"], "vary"=>["Accept-Encoding"], "p3p"=>["CP=\"ALL ADM DEV PSAi COM OUR OTRo STP IND ONL\""], "x-ua-compatible"=>["IE=Edge,chrome=1"], "transfer-encoding"=>["chunked"], "date"=>["Fri, 21 Mar 2014 17:48:47 GMT"], "connection"=>["close"]})

      visit '/'
      fill_in "username", :with => "davidslog.com"
      click_button "Search"
    end

    it "shows the first page of questions and answers" do
      expect(page).to have_content("Hey, I've been wondering.. What IDE(s) are the developers at Tumblr using")
    end

    it "allows navigation to subsequent pages" do
      json_response = File.read(File.dirname(__FILE__) + "/../support/json_responses/tumblr_questions_page_2.json")

      stub_request(:get, /.*api\.tumblr\.com\/v2\/blog\/.*\/posts\/answer\?api_key=.*&filter=text&offset=20/).to_return(:status => 200, :body => json_response, :headers => {"content-type"=>["application/json; charset=utf-8"], "vary"=>["Accept-Encoding"], "p3p"=>["CP=\"ALL ADM DEV PSAi COM OUR OTRo STP IND ONL\""], "x-ua-compatible"=>["IE=Edge,chrome=1"], "transfer-encoding"=>["chunked"], "date"=>["Fri, 21 Mar 2014 17:48:47 GMT"], "connection"=>["close"]})

      click_link "Next"
      expect(page).to have_content("Who chooses what is going on radar?")
    end

    it "warns the user when an invalid page number is entered" do
      json_response = File.read(File.dirname(__FILE__) + "/../support/json_responses/tumblr_questions_empty.json")

      stub_request(:get, /.*api\.tumblr\.com\/v2\/blog\/.*\/posts\/answer\?api_key=.*&filter=text&offset=3980/).to_return(:status => 200, :body => json_response, :headers => {"content-type"=>["application/json; charset=utf-8"], "vary"=>["Accept-Encoding"], "p3p"=>["CP=\"ALL ADM DEV PSAi COM OUR OTRo STP IND ONL\""], "x-ua-compatible"=>["IE=Edge,chrome=1"], "transfer-encoding"=>["chunked"], "date"=>["Fri, 21 Mar 2014 17:48:47 GMT"], "connection"=>["close"]})

      visit '/davidslog.com/200'
      expect(page).to have_content("That user does not exist or they have no Asks available")
    end
  end

  context "when a valid Tumblr user is search for but they have no Asks" do
    it "notifies the user that the Tumblr user they searched for has no Asks" do
      json_response = File.read(File.dirname(__FILE__) + "/../support/json_responses/tumblr_questions_no_asks.json")

      stub_request(:get, /.*api\.tumblr\.com\/v2\/blog\/.*\/posts\/answer\?api_key=.*&filter=text&offset=0/).to_return(:status => 200, :body => json_response, :headers => {"content-type"=>["application/json; charset=utf-8"], "vary"=>["Accept-Encoding"], "p3p"=>["CP=\"ALL ADM DEV PSAi COM OUR OTRo STP IND ONL\""], "x-ua-compatible"=>["IE=Edge,chrome=1"], "transfer-encoding"=>["chunked"], "date"=>["Fri, 21 Mar 2014 17:48:47 GMT"], "connection"=>["close"]})

      visit '/'
      fill_in "username", :with => "auserwithnoasks"
      click_button "Search"
      expect(page).to have_content("That user does not exist or they have no Asks available")
    end
  end

  context "when an invalid Tumblr username is entered" do
    before do

      json_response = File.read(File.dirname(__FILE__) + "/../support/json_responses/404.json")

      stub_request(:get, /.*api\.tumblr\.com\/v2\/blog\/.*\/posts\/answer\?api_key=.*&filter=text&offset=0/).to_return(:status => 200, :body => json_response, :headers => {"content-type"=>["application/json; charset=utf-8"], "vary"=>["Accept-Encoding"], "p3p"=>["CP=\"ALL ADM DEV PSAi COM OUR OTRo STP IND ONL\""], "x-ua-compatible"=>["IE=Edge,chrome=1"], "transfer-encoding"=>["chunked"], "date"=>["Fri, 21 Mar 2014 17:48:47 GMT"], "connection"=>["close"]})

      visit '/'
      fill_in "username", :with => "thisisausernamethatdoesnnotexist12345678"
      click_button "Search"
    end

    it "notifies the user that the user does not exist" do
      expect(page).to have_content("That user does not exist or they have no Asks available")
    end
  end
end
