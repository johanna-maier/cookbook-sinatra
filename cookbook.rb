require "csv"
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv if @csv_file_path
    # loads existing Recipe from the CSV
  end

  def all
    return @recipes
    # return all recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv if @csv_file_path
    # add new recipe to cookbook
  end

  def remove_recipe(recipe_index)

    @recipes.delete_at(recipe_index)

    save_csv if @csv_file_path
    # remove recipe from CSV
  end

  def mark_completed(recipe_index)
    @recipes[recipe_index].mark_completed!
    save_csv if @csv_file_path
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      attributes = {
        name: row[0],
        description: row[1],
        rating: row[2],
        completed: row[3],
        prep_time: row[4]
      }
      @recipes << Recipe.new(attributes)
      # Here, row is an array of columns
    end
  end

  # load CSV with new parameter argument hash
  # def load_csv
  #   csv_options = {headers: :first_row, header_converters: :symbol}
  #   CSV.foreach(@csv_file_path, csv_options) do |row|
  #     recipe = Recipe.new(row)
  #     @recipes << recipe # Here, row is an array of columns
  #   end
  # end

  # We are given the file path and ask to consider the csv options while parsing the document.

  # def save_csv
  #   CSV.open(@csv_file_path, "wb") do |csv|
  #     csv << ["name", "description", "rating", "completed", "prep_time"]
  #     @recipes.each do |recipe|
  #       csv << [recipe.name, recipe.description, recipe.rating, recipe.completed, recipe.prep_time]
  #     end
  #   end
  # end

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.completed, recipe.prep_time]
      end
    end
  end

end

# my_cookbook = Cookbook.new("recipes.csv")
# my_cookbook.remove_recipe(0)
# my_cookbook.save_csv

# my_cookbook.remove_recipe(2)
# my_cookbook.all

# p my_cookbook
