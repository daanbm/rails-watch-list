# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

Movie.destroy_all

url = "http://tmdb.lewagon.com/movie/top_rated"
movies_doc = URI.open(url).read
movies = JSON.parse(movies_doc)

movies["results"].each do |movie|
  file = URI.open("https://image.tmdb.org/t/p/original#{movie["poster_path"]}")
  newmovie = Movie.new(
    title: movie["original_title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
  newmovie.photo.attach(io: file, filename: "#{movie['original_title']}_poster.png", content_type: 'image/png')
  newmovie.save
end
