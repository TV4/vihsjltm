require 'sinatra'
require 'erb'
require 'yaml'

INGREDIENTS = YAML::load(open('with-meat.yml'))

VEGAN = YAML::load(open('without-meat.yml'))

get '/' do
  @i_dont_play_that ="JAG ÄTER FÖR I HELVETE INTE KÖTT"
  @hit_me_again_link = "/"
  @i_dont_play_that_link="/vegan"
  @recipe_title, @recipe_link = find_dinner INGREDIENTS
  erb :index
end

get '/vegan' do
  @hit_me_again_link = "/vegan"
  @i_dont_play_that="JAG ÄR VÄL FÖR I HELVETE INGEN GRÄSÄTARE"
  @i_dont_play_that_link="/"
  @recipe_title, @recipe_link = find_dinner VEGAN
  erb :index
end

def find_dinner(arr)
  title = arr.keys[rand(arr.keys.size)]
  link = arr[title]
  return title, link
end
