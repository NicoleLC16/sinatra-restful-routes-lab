class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do #index page
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do #new recipe form page
    erb :new
  end

  post '/recipes' do #create new recipie 
    @recipe = Recipe.create(params)
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do #show page
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #edit form page
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #patch edit
    @recipe = Recipe.find(params[:id])
    # @recipe.update(params[:name], 
    # params[:ingredients], 
    # params[:cook_time])
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
    # binding.pry
  end

  delete '/recipes/:id' do #delete a recipe
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect "/recipes"
  end

end
