require 'sinatra'
require 'curb'
require 'nokogiri'
require 'erb'

SEARCH_URL = "http://www.recept.nu/1.118748?search=true&page=0&view=xml&rcp_recipeCategory=" + URI.encode("Varmrätter")

INGREDIENTS = ["Kött", "Köttfärs", "Korv &amp; chark", "Vilt", "Kyckling &amp; fågel", "Fisk &amp; skaldjur", "Alkohol", "Pasta &amp; nudlar", "Ris, couscous &amp; andra gryn", "Grönsaker, potatis &amp; andra rotfrukter", "Ärtor¸ bönor &amp; linser", "Frukt &amp; bär", "Ägg &amp; mejeri", "Mjöl"] 

VEGAN = ["Alkohol", "Pasta &amp; nudlar", "Ris, couscous &amp; andra gryn", "Grönsaker, potatis &amp; andra rotfrukter", "Ärtor¸ bönor &amp; linser", "Frukt &amp; bär", "Ägg &amp; mejeri", "Mjöl"] 

get '/' do
  @i_dont_play_that ="JAG ÄTER FÖR I HELVETE INTE KÖTT"
#  @recipe_title, @recipe_link = find_dinner("&rcp_mainIngredientCategory=" + URI.encode(INGREDIENTS.sort!{rand}[0]))
  erb :index
end

get '/vegan' do
  @i_dont_play_that="JAG ÄR VÄL FÖR I HELVETE INGEN GRÄSÄTARE"
#  @recipe_title, @recipe_link = find_dinner("&rcp_green=true&rcp_mainIngredientCategory=" + URI.encode(VEGAN.sort!{rand}[0]))
  erb :index
end

def find_dinner(param)
  rss = Curl::Easy.perform(SEARCH_URL + param).body_str
  doc = Nokogiri::XML(rss)
  title = doc.xpath('//title')[2].text
  link = doc.xpath('//link')[2].text
  return title, link
end
