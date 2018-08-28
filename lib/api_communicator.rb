require 'rest-client'
require 'json'
require 'pry'

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

def get_character_movies_from_api(character)
  response_hash = get_response_hash
  movie_urls = get_movie_urls(response_hash, character)
  get_movie_info(movie_urls)
end

def get_response_hash
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  JSON.parse(response_string)
end

def get_movie_urls(movie_hashes, character)
  movie_urls = []
  movie_hashes["results"].each do |character_hash|
    if character_hash["name"].downcase == character
      movie_urls = character_hash["films"]
    end
  end
  movie_urls
end

def get_movie_info(movie_urls)
  movie_urls.map do |url|
    movie_string = RestClient.get(url)
    movie_hash = JSON.parse(movie_string)
  end
end

def print_movies(films_hash)
  films_hash.each do |movie_info|
    puts movie_info["title"]
    puts movie_info["release_date"]
  end
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
