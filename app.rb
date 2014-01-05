require 'sinatra/base'
require 'haml'
require 'pry'

require './lib/tumblr_question'
require './lib/tumblr_asks'

class App < Sinatra::Base

  before do 
    
  end

  get '/' do
    haml :home
  end

  get '/search' do
    @asks = TumblrAsks.new(params[:username], 1)
    @current_page_no = 1

    haml :questions
  end

  get '/:username' do
    @asks = TumblrAsks.new(params[:username], 1)
    @current_page_no = 1

    haml :questions
  end

  get '/:username/:page_start' do
    @asks = TumblrAsks.new(params[:username], params[:page_start].to_i )
    @current_page_no = params[:page_start].to_i

    haml :questions
  end
end