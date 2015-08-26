require 'sinatra/activerecord'
require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require 'pry'
require './lib/tag'
require './lib/recipe'
require 'sinatra/partial'
# require 'sinatra/activerecord'
# require("bundler/setup")
# Bundler.require(:default)
#
# Dir[File.dirname(_FILE_) + '/lib/*.rb'].each { |file| require file}

get '/'  do
	erb(:index)
end

get '/recipes' do
	erb(:recipes)
end

post '/recipes' do
	@recipe = Recipe.create({ name: params['name'], ingredients: params['ingredients'], instructions: params['instructions'] })
	redirect "/recipes/#{@recipe.id}"
end

get '/recipes/:id' do
	@recipe = Recipe.find(params['id'].to_i)
	erb(:recipe)
end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params['id'].to_i)
	erb :recipe_edit
end

delete '/recipes/:id' do
	@recipe = Recipe.find(params['id'].to_i)
	@recipe.destroy
	redirect "/recipes"
end

patch '/recipes/:id' do
	@recipe = Recipe.create({ name: params['name'], ingredients: params['ingredients'], instructions: params['instructions'] })
	redirect "/recipes/#{@recipe.id}"
end

get '/recipes/:id/tag/new' do
	@recipe = Recipe.find(params['id'].to_i)
	erb :tag_form
end

post '/recipes/:id/tags' do
	@recipe = Recipe.find(params['id'].to_i)
	@tag = Tag.create({ name: params['tag_name'] })
	@recipe.tags.push(@tag)
	redirect "/recipes/#{@recipe.id}"
end

get '/recipes/:id/tags/:tag_id/delete' do
  @tag = Tag.find(params['tag_id'].to_i)
	@recipe = Recipe.find(params['id'].to_i)
	@tag.destroy
	redirect "/recipes/#{@recipe.id}"
end

get '/recipes/:id/tags/:tag_id/edit' do
	@recipe = Recipe.find(params['id'].to_i)
	@tag = Tag.find(params['tag_id'].to_i)
  erb :tag_edit
end

patch '/recipes/:id/tags/:tag_id' do
	@recipe = Recipe.find(params['id'].to_i)
	@tag = Tag.find(params['tag_id'].to_i)
	@tag.update({ name: params['tag_name'] })
	redirect "/recipes/#{@recipe.id}"
end
