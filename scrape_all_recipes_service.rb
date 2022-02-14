class ScrapeAllrecipesService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    url = "https://www.allrecipes.com/search/results/?search=#{@keyword}"
    html_content = URI.open(url, "User-Agent" => "Screaming Frog").read
    doc = Nokogiri::HTML(html_content)
    recipe_instances = get_recipe_details(doc)
    return recipe_instances
  end


  def get_recipe_details(doc)
    recipe_instances = []
    doc.search('.card__detailsContainer-left').first(5).each do |recipe_card|
      name = recipe_card.search(".card__titleLink").text.strip
      # recipe_name = recipe_card.children[1]['title']
      desc = recipe_card.search(".card__summary").text.strip
      desc = (desc[0..70]...) if desc.length >= 70

      # recipe_description = recipe_card.children[5].text.strip.gsub(/\n(\s*\n)+/," ")
      rating_node = recipe_card.children[3].children[1]
      if rating_node.nil?
        rating = nil
      else
       rating = rating_node.children[1].text.gsub(/Rating: /, "").gsub(/ stars/, "").to_i
      end
      recipe_link = recipe_card.children[1]['href']
      prep_time = get_prep_time(recipe_link)

      recipe_instances << create_recipe_instance(name, desc, rating, prep_time)
    end
    return recipe_instances
  end

  def get_prep_time(recipe_link)
    html_content = URI.open(recipe_link, "User-Agent" => "Screaming Frog").read
    doc = Nokogiri::HTML(html_content)
    prep_time_node = doc.search('.recipe-meta-container')

    if prep_time_node.children[1].children[7].nil?
      recipe_prep_time = nil
    else
      recipe_prep_time = prep_time_node.children[1].children[7].children[3].text.strip
    end
    return recipe_prep_time
  end

  def create_recipe_instance(name, desc, rating, prep_time)
    attributes = {
      name: name,
      description: desc,
      rating: rating,
      prep_time: prep_time
    }
    return Recipe.new(attributes)
  end
end
