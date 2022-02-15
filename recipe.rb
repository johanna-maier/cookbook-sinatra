class Recipe
  attr_reader :name, :description, :prep_time
  attr_accessor :rating, :completed

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @completed = attributes[:completed] || false
    @prep_time = attributes[:prep_time]
  end

  def mark_completed!
    @completed = true
  end
end

# chocolate_cake = Recipe.new("chocolate cake", "Add a lot of chocolate, flour and done.", 5)
# p chocolate_cake
