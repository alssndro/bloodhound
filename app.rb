require 'sinatra/base'
require 'haml'
require 'sinatra/flash'

# recursively require all model files
Dir[Dir.pwd + "/models/**/*.rb"].each { |f| require f }

class App < Sinatra::Base

  configure do
    enable :sessions
    register Sinatra::Flash
  end

  get '/' do
    haml :home
  end

  before do
    # Creates the TumblrAsk object required for the view templates,
    # redirecting if the username does not exist
    def create_asks(page_start = 1)
      @asks = TumblrAsks.new(params[:username])

      # Condition returns false if the user does not exist
      if @asks.questions(page_start)
        @current_page_no = page_start

        haml :questions
      else
        flash[:error] = "That user does not exist"
        redirect to('/')
      end
    end
  end

  get '/search/?' do
    create_asks
  end

  get '/:username/?' do
    create_asks
  end

  get '/:username/:page_start/?' do
    create_asks(params[:page_start].to_i)
  end
end
