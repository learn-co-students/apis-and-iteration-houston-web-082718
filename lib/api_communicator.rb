require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(input_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  person_info = response_hash["results"].find do |character|
    character["name"].downcase == input_name
  end

  if !person_info
    return nil
  end

  films_array = []
  person_info["films"].each do |film|
    films_array << JSON.parse(RestClient.get(film))
  end
  films_array.each do |film|
    film.delete_if do |film_property_key, film_property_value|
      film_property_key != "title" && film_property_key != "episode_id" && film_property_key != "opening_crawl"
    end
  end
  films_array = sort_films_by_episode_id(films_array)
  # films_array.select do
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def sort_films_by_episode_id(films_array)
  films_array.sort do |film1, film2|
    film1["episode_id"] <=> film2["episode_id"]
  end
end

def print_movies(films_array)
  films_array.each do |film|
    puts film["title"]
    puts "Episode: #{film["episode_id"]}"
    puts film["opening_crawl"]
    puts "*" * 30
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  if films_array
    print_movies(films_array)
  else
    puts "do you even star wars"
  end
end
