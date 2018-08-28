require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  film_url_array = []

  #response_hash["results"].each do |character_hash|
  #  if character_hash["name"].upcase == character.upcase
  #    film_url_array = character_hash["films"]
  #    #binding.pry
  #  end
  #end

  # NOTE: in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  #film_url_array.collect do |film_url|
  #  film_string = RestClient.get(film_url)
  #  film_hash = JSON.parse(film_string)
  #  film_hash["title"]
  #  #binding.pry
  #end

  get_film_title(get_film_urls(response_hash, character))
end

def get_film_urls(response_hash, character)
  film_url_array = []

  response_hash["results"].each do |character_hash|
    if character_hash["name"].upcase == character.upcase
      film_url_array = character_hash["films"]
      #binding.pry
    end
  end
  film_url_array
end

def get_film_title(film_url_array)
  film_url_array.collect do |film_url|
    film_string = RestClient.get(film_url)
    film_hash = JSON.parse(film_string)
    film_hash["title"]
    #binding.pry
  end
end


def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film_title|
    puts film_title
  end
end



def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
