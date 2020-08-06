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
    if session[:user_id]
      @user = User.find(session[:user_id])
      erb :account
    else
      redirect "/login"
    end
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      binding.pry
      redirect "/account"
    else
      erb :login
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  get "/new" do
    erb :new
  end

  post "/recipes" do
    binding.pry
    @recipe = Recipe.create(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], 
                            tags: params[:tags], link: params[:link], user_id: session[:user_id])
    redirect "/account"
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by(user_id: session[:user_id])
    erb :edit
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

end
