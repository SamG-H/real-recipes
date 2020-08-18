class UsersController < ApplicationController

  get "/signup" do
    erb :'users/signup'
  end

  post "/signup" do
    @user = User.new(params)
    if user.save
      session[:user_id] = @user.id
      redirect to "/recipes"
    else
      @errors = @user.errors.full_messages
      erb :'users/signup'
    end
  end

  get "/login" do
    erb :'users/login'
  end

  post "/login" do
    set_user
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
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

  private
  def set_user
    @user = User.find_by(username: params[:username])
  end
  
end

