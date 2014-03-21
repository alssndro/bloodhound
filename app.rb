require 'sinatra/base'
require 'haml'

# recursively require all model files
Dir[Dir.pwd + "/models/**/*.rb"].each { |f| require f }

class App < Sinatra::Base

  helpers do
    def check_user_exists(asks)

    end
  end

  get '/' do
    haml :home
  end

  get '/search/?' do
    # Check that the user exists
    @asks = TumblrAsks.new(params[:username])

    if @asks.questions
      @current_page_no = 1

      haml :questions
    else
      haml :user_does_not_exist
    end
  end

  get '/:username/?' do
    @asks = TumblrAsks.new(params[:username])
    @asks.questions(1)
    @current_page_no = 1

    haml :questions
  end

  get '/:username/:page_start/?' do
    @asks = TumblrAsks.new(params[:username])
    @asks.questions(params[:page_start].to_i)
    @current_page_no = params[:page_start].to_i

    haml :questions
  end
end