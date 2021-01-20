require './config/environment'

class ApplicationController < Sinatra::Base

  # Tell tilt to render html.erb files not just .erb
  Tilt.register Tilt::ERBTemplate, 'html.erb'

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

    def redirect_to_login
      redirect to '/login' if !logged_in?
    end

    def authorized?(record)
      record && record.user_id == current_user.id
    end

    def redirect_if_not_authorized(record)
      redirect to '/recipes' if !authorized?(record)
    end
        
  end

end
