class UsersController < ApplicationController

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
  
end

