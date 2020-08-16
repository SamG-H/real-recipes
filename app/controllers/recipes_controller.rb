class RecipesController < ApplicationController

  get "/recipes" do
    if logged_in?
      @user = current_user
      erb :'recipes/recipes'
    else
      redirect to "/login"
    end
  end

  get "/recipes/new" do
    if logged_in?
      erb :'recipes/new'
    else
      redirect to "/login"
    end
  end

  post "/recipes" do
    if logged_in?
      @recipe = Recipe.new(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], tags: params[:tags], link: params[:link], user_id: session[:user_id])
      if @recipe.save
        redirect to "/recipes"
      else
        @error = @recipe.errors.messages[:name][0]
        erb :'recipes/new'
      end
    else
      redirect to "/login"
    end
  end

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe && @recipe.user_id == current_user.id
        erb :'recipes/edit'
      else
        erb :uhoh
      end
    else
      redirect to '/login'
    end
  end

  get '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe && @recipe.user_id == current_user.id
        @recipe = Recipe.find(params[:id])
        User.find(@recipe.user_id)
        erb :'recipes/show'
      else
        erb :uhoh
      end
    else
      redirect to "/login"
    end
  end

  patch '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe && @recipe.user_id == current_user.id
        @recipe.update(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], tags: params[:tags], link: params[:link])
        if @recipe.errors.messages.empty?
          redirect to "/recipes/#{@recipe.id}"
        else
          @error = @recipe.errors.messages[:name][0]
          @recipe = Recipe.find_by(id: params[:id])
          erb :'recipes/edit'
        end
      else
        erb :uhoh
      end
    else
      redirect to "/login"
    end
  end

  delete '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find_by(id: params[:id])
      if @recipe && @recipe.user_id == current_user.id
        @recipe.destroy
        redirect to '/recipes'
      else
        erb :uhoh
      end
    else
      redirect to "/login"
    end
  end

end

