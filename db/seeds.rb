require 'date'
JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

id = 1
JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  this_movie = Movie.new
  this_movie.title = movie["title"]
  this_movie.overview = movie["overview"]
  this_movie.release_date = movie["release_date"]
  this_movie.inventory = movie["inventory"]
  this_movie.id = id
    id+= 1
  this_movie.created_at = Date.today
  this_movie.updated_at = Date.today
  puts this_movie
  this_movie.save
end
