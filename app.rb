require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'scrape_all_recipes_service'
require 'nokogiri'
require 'open-uri'

set bind: 'localhost'
set port: 7655

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end


get '/' do
  @cookbook = Cookbook.new('recipes.csv')
  @recipes = @cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  @cookbook = Cookbook.new('recipes.csv')

  @name = params[:name]
  @desc = params[:description]

  @rating = params[:rating]
  @time = params[:time]

  @recipe = Recipe.new(name: @name, description: @desc, rating: @rating, prep_time: @time)

  @cookbook.add_recipe(@recipe)
  redirect '/'
end

get "/destroy/:index" do
  @cookbook = Cookbook.new('recipes.csv')
  @index = params[:index].to_i
  @cookbook.remove_recipe(@index)
  redirect '/'
end
