require_relative 'view'
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'scrape_all_recipes_service'
require "nokogiri"
require "open-uri"


class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    new_recipe_data = @view.new_recipe
    attributes = {
      name: new_recipe_data[0],
      description: new_recipe_data[1],
      rating: new_recipe_data[2],
      prep_time: new_recipe_data[3]
    }

    new_recipe = Recipe.new(attributes)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    recipes = @cookbook.all
    recipe_index = @view.delete_recipe(recipes) - 1
    @cookbook.remove_recipe(recipe_index)
  end

  def import_recipe
    # view has to ask for the keyword
    keyword = @view.ask_user_for_import_keyword
    # controller has to give back a list of choices
    recipe_instances = ScrapeAllrecipesService.new(keyword).call
    # view has display choices ask for index
    recipe_index = @view.ask_user_for_import_index(recipe_instances) - 1
    # controller has to add selected instance to cookbook
    @cookbook.add_recipe(recipe_instances[recipe_index])
    @cookbook.all
  end

  def mark_completed
    recipes = @cookbook.all
    recipe_index = @view.mark_compelted(recipes) - 1
    @cookbook.mark_completed(recipe_index)
  end

end
