require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  # : in this demonstration we name many of the variables _hash or _array.
  # This is done for educational purposes. This is not typically done in code.
  results_array = response_hash["results"]

    # if results_array[0]["name"] == character
    #   results_array[0]["films"].each do |url|
    #     string_url = RestClient.get(url)
    #     hash_url = JSON.parse(string_url)
    #   end
    # end

   results_array.each do |result_hash|
      if result_hash["name"].downcase == character
        films_hash_array = []
        result_hash["films"].each do |url|
          string_url = RestClient.get(url)
          hash_url = JSON.parse(string_url)
          films_hash_array << hash_url
        end
      end
    end
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

def print_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film_hash|
    puts film_hash 
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

get_character_movies_from_api('luke skywalker')

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
