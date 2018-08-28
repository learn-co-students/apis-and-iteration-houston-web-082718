require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(input_name)
  #make the web request
  person_info = find_info_for_character(input_name)
  if !person_info
    return nil
  end
  print_found_characters_name(input_name, person_info)

  films_array = get_films_for_character(person_info)

  trimmed_film_info = trim_film_info(films_array)

  sort_films_by_episode_id(trimmed_film_info)
end

def find_info_for_character(input_name)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  response_hash["results"].find do |character|
    character.values.include?(input_name)
  end
end

def trim_film_info(films_array)
  films_array.each do |film|
    film.delete_if do |film_property_key, film_property_value|
      film_property_key != "title" && film_property_key != "episode_id" && film_property_key != "opening_crawl"
    end
  end
  films_array
end

def get_films_for_character(person_info)
  films_array = []
  person_info["films"].each do |film|
    films_array << JSON.parse(RestClient.get(film))
  end
  films_array
end

def print_found_characters_name(input_name, person_info)
  if person_info["name"] != input_name
    puts person_info["name"]
  end
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
