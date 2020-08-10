class RecipesController < ApplicationController

  get "/recipes" do
    if logged_in?
      @user = User.find(session[:user_id])
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
    @recipe = Recipe.create(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], 
                            tags: params[:tags], link: params[:link], color: params[:color], user_id: session[:user_id])
    redirect to "/recipes"
  end

  get '/recipes/:id/edit' do
    if logged_in?
      @recipe = Recipe.find(params[:id])
      if @recipe.user_id == current_user.id
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
      @recipe = Recipe.find(params[:id])
      if Recipe.last.id < params[:id].to_i
        erb :uhoh
      elsif @recipe && @recipe.user_id == current_user.id
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
      @recipe = Recipe.find(params[:id])
      if @recipe && @recipe.user_id == current_user.id
        @recipe.update(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients], tags: params[:tags], link: params[:link], color: params[:color])
        redirect to "/recipes/#{@recipe.id}"
      else
        erb :uhoh
      end
    else
      redirect to "/login"
    end
  end

  delete '/recipes/:id' do
    if logged_in?
      @recipe = Recipe.find(params[:id])
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

