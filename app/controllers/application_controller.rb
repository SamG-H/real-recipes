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
    if (params[:username] == "" || params[:password] == "")
      @error = "You must type in a username and a password"
      erb :signup
    elsif User.find_by(username: params[:username])
      @error = "Username taken"
      erb :signup
    else
      user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = user.id
      redirect "/recipes"
    end
  end

  get "/recipes" do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :recipes
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
      redirect "/recipes"
    else
      @error = "Incorrect username or password"
      erb :login
    end
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  get "/recipes/new" do
    if logged_in?
      erb :new
    else
      redirect "/login"
    end
  end

  post "/recipes" do
    @recipe = Recipe.create(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], 
                            tags: params[:tags], link: params[:link], color: params[:color], user_id: session[:user_id])
    redirect "/recipes"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id
      erb :edit
    else
      redirect "/uhoh"
    end
  end

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find(params[:id])
      if Recipe.last.id < params[:id].to_i
        erb :uhoh
      elsif @recipe.user_id == current_user.id
        @recipe = Recipe.find(params[:id])
        User.find(@recipe.user_id)
        erb :show
      else
        erb :uhoh
      end
    else
      redirect "/login"
    end
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    if @recipe.user_id == current_user.id
      @recipe.update(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], 
                     tags: params[:tags], link: params[:link], color: params[:color])
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/uhoh"
    end
  end

  delete '/recipes/:id' do
    if @recipe.user_id == current_user.id
      @recipe = Recipe.find(params[:id])
      @recipe.destroy
      redirect '/recipes'
    else
      redirect "/uhoh"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
