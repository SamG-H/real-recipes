class RecipesController < ApplicationController

  get "/recipes" do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :recipes
    else
      redirect "/login"
    end
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
      erb :uhoh
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

end

