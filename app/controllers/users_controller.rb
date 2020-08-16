class UsersController < ApplicationController

  get "/signup" do
    erb :'users/signup'
  end

  post "/signup" do
    user = User.new(username: params[:username], password: params[:password])
    
    if User.find_by(username: params[:username])
      @error = "Username taken"
      erb :'users/signup'
    elsif user.save
      session[:user_id] = user.id
      redirect to "/recipes"
    else
      errorhash = user.errors.messages
      if errorhash[:username] && errorhash[:password]
        @error = "Username and password #{errorhash[:username][0]}"
        erb :'users/signup'
      elsif errorhash[:username]
        @error = "Username #{errorhash[:username][0]}"
        erb :'users/signup'
      else
        @error = "Password #{errorhash[:password][0]}"
        erb :'users/signup'
      end
    end
  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/recipes"
    else
      @error = "Incorrect username or password"
      erb :'users/login'
    end
  end

  get "/logout" do
    session.clear
    redirect to "/"
  end
  
end

