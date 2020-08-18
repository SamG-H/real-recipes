class RecipesController < ApplicationController

  get "/recipes" do
    redirect_to_login?
    erb :'recipes/recipes'
  end

  get "/recipes/new" do
    redirect_to_login?
    erb :'recipes/new'
  end

  post "/recipes" do
    redirect_to_login?
    create_recipe
    if @recipe.save
      redirect to "/recipes"
    else
      @errors = @recipe.errors.full_messages
      erb :'recipes/new'
    end
  end

  get '/recipes/:id/edit' do
    redirect_to_login?
    set_recipe
    redirect_if_not_authorized(@recipe)
    erb :'recipes/edit'
  end

  get '/recipes/:id' do
    redirect_to_login?
    set_recipe
    redirect_if_not_authorized(@recipe)
    erb :'recipes/show'
  end

  patch '/recipes/:id' do
    redirect_to_login?
    set_recipe
    redirect_if_not_authorized(@recipe)
    params.delete('_method')
    if @recipe.update(params)
      redirect to "/recipes/#{@recipe.id}"
    else
      @errors = @recipe.errors.full_messages
      erb :'recipes/edit'
    end
  end

  delete '/recipes/:id' do
    redirect_to_login
    set_recipe
    redirect_if_not_authorized(@recipe)
    @recipe.destroy
    redirect to '/recipes'
  end

  private
  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end

  def create_recipe
    @recipe = current_user.recipes.new(params)
  end
  
end

