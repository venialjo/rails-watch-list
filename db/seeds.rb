# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

puts 'First... deleting all movies from database...'
sleep 1
Movie.destroy_all

url = 'http://tmdb.lewagon.com/movie/top_rated'
movies = JSON.parse(URI.parse(url).open.read)

movies['results'].each do |movie|
  puts "Adding #{movie['title']}"
  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  )
  sleep 0.05
end

puts 'Finished Adding Movies!'
