require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  
  # NOTE: in this demonstration we name many of the variables _hash or _array. 
  # This is done for educational purposes. This is not typically done in code.

  results_arr = response_hash["results"]
  movies_arr = []
  results_arr.each{|hash| 
    if hash["name"] == character
      movies_arr = hash["films"]
    end 
  }
  movies_arr.map do |link|
    get_movie = RestClient.get(link)
    movie_hash = JSON.parse(get_movie)
    print_movies(movie_hash)
  end
  

    # return response_hash["films"]

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

def print_movies(movie_hash)
  # some iteration magic and puts out the movies in a nice list
  if movie_hash.is_a?(Hash)
    puts movie_hash["title"]
  end 
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
