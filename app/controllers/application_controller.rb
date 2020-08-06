require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      erb :signup
    else
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect "/account"
    end
  end

  get "/account" do
    @user = User.find(session[:user_id])
    erb :account
  end

  get "/login" do
    erb: login
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
    else
      erb :login
    end
  end

end
