require 'rest-client'
require 'json'
require 'pry'

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

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  films_array = []

  response_hash["results"].each do |character_hash|
    if character_hash["name"] == character
      character_hash["films"].each do |film_url|
        film_info = RestClient.get(film_url)
        film_info_hash = JSON.parse(film_info)
        films_array << film_info_hash
       end
    end
  end
  films_array
end

# get_character_movies_from_api("Luke Skywalker")

def print_movies(films_array)
    i = 1
    films_array.each do |film_hash|
      puts "#{i} #{film_hash["title"]}"
        i +=1
      end

  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
