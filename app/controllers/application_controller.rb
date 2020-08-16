require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "SESSION_KEY"
  end

  get "/" do
      erb :index
  end

  not_found do
    status 404
    erb :uhoh
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find_by(id: session[:user_id])
    end
  end

end
