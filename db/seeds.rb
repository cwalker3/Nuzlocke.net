# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "net/http"
require "json"

# uri   = URI("https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")
# body  = Net::HTTP.get(uri)

# names = JSON.parse(body)["results"].map { |r| r["name"] }

# Pokemon.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!('pokemon')

# names.each do |name|
#   Pokemon.find_or_create_by!(species: name)
# end


# uri = URI("https://pokeapi.co/api/v2/move?limit=100000&offset=0")
# body = Net::HTTP.get(uri)

# Move.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!('move')

# moves = JSON.parse(body)["results"].map { |r| r["name"] }
# moves.each do |name|
#   Move.find_or_create_by!(name: name)
# end

# uri = URI("https://pokeapi.co/api/v2/item?limit=100000&offset=0")
# body = Net::HTTP.get(uri)

# Item.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!('item')

# items = JSON.parse(body)["results"].map { |r| r["name"] }
# items.each do |name|
#   Item.find_or_create_by!(name: name)
# end

# uri = URI("https://pokeapi.co/api/v2/ability?limit=100000&offset=0")
# body = Net::HTTP.get(uri)

# Ability.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!('ability')

# abilities = JSON.parse(body)["results"].map { |r| r["name"] }
# abilities.each do |name|
#   Ability.find_or_create_by!(name: name)
# end

# uri = URI("https://pokeapi.co/api/v2/nature?limit=100000&offset=0")
# body = Net::HTTP.get(uri)

# Nature.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!('nature')

# natures = JSON.parse(body)["results"].map { |r| r["name"] }
# natures.each do |name|
#   Nature.find_or_create_by!(name: name)
# end





