require 'curb'
require 'rss/2.0'
require 'yaml'

def find_dinner(param)
  content = Curl::Easy.perform(SEARCH_URL + param).body_str
  doc = RSS::Parser.parse(content, false)
end

INGREDIENTS = ["Kött", "Köttfärs", "Korv &amp; chark", "Vilt", "Kyckling &amp; fågel", "Fisk &amp; skaldjur", "Alkohol", "Pasta &amp; nudlar", "Ris, couscous &amp; andra gryn", "Grönsaker, potatis &amp; andra rotfrukter", "Ärtor¸ bönor &amp; linser", "Frukt &amp; bär", "Ägg &amp; mejeri", "Mjöl"] 

VEGAN = ["Alkohol", "Pasta &amp; nudlar", "Ris, couscous &amp; andra gryn", "Grönsaker, potatis &amp; andra rotfrukter", "Ärtor¸ bönor &amp; linser", "Frukt &amp; bär", "Ägg &amp; mejeri", "Mjöl"] 

SEARCH_URL = "http://www.recept.nu/1.118748?search=true&sortDate=true&page=0&view=xml&rcp_recipeCategory=" + URI.encode("Varmrätter")

ingredient_hash = {}
VEGAN.each do |term|
  rss = find_dinner("&rcp_green=true&rcp_mainIngredientCategory=" + URI.encode(term))
  rss.items.each do |item| 
    ingredient_hash[item.title] = item.link
  end
end
yaml_file = File.new("data2.yml", 'w')
yaml_file.puts YAML.dump(ingredient_hash)
yaml_file.close

