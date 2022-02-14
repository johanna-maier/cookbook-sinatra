class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      rating = recipe.rating.nil? ? "no ratings" : "#{recipe.rating} / 5"
      prep_time = recipe.prep_time.nil? ? "no time given" : recipe.prep_time
      completed = recipe.completed == true ? "x" : " "

      puts "#{index + 1}. [#{completed}] #{recipe.name}: #{recipe.description} (#{rating})  | prep time: #{prep_time}"
    end
  end

  def new_recipe
    puts "What is your recipe name, description, rating & prep time?"
    print "Name: "
    recipe_name = gets.chomp
    print "Description: "
    recipe_description = gets.chomp
    print "Rating: "
    recipe_rating = gets.chomp
    print "Prep time: "
    recipe_prep_time = gets.chomp
    return [recipe_name, recipe_description, recipe_rating, recipe_prep_time]
  end

  def delete_recipe(recipes)
    puts "Which index do you want to delete?"
    display(recipes)
    print "Index: "
    recipe_index = gets.chomp.to_i
    return recipe_index
  end

  def mark_compelted(recipes)
    puts "Which index do you want to mark as completed?"
    display(recipes)
    print "Index: "
    recipe_index = gets.chomp.to_i
    return recipe_index
  end

  def ask_user_for_import_keyword
    puts "What ingredient would you like a recipe for?"
    print "Keyword: "
    keyword = gets.chomp
    return keyword
  end

  def ask_user_for_import_index(recipe_instances)
    recipe_instances.each_with_index do |recipe_instance, index|
      rating = recipe_instance.rating.nil? ? "no ratings" : "#{recipe_instance.rating} / 5"
      puts "#{index + 1}. #{recipe_instance.name} (#{rating})"
    end

    puts "What index do you want to import?"
    print "Index: "
    recipe_index = gets.chomp.to_i
    puts "Importing '#{recipe_instances[recipe_index - 1].name}'"
    return recipe_index
  end
end
