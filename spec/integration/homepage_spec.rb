require 'test_helper'

class  HomepageTest < MiniTest::Test
  
  include Rack::Test::Methods

  def app
    App
  end

  def test_something_in_app
    assert_equal true, true
  end

  def test_homepage
    get '/'
    assert last_response.ok?
  end
end