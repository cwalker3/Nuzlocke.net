# require "net/http"
# require "json"

# uri   = URI("https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")
# body  = Net::HTTP.get(uri)

# data = JSON.parse(body)["results"].map { |r| [r["name"], 
# r["url"].split('/')[-1]
# ] }

# Pokemon.destroy_all
# ActiveRecord::Base.connection.reset_pk_sequence!('pokemon')

# data.each do |name, dex_number|
#   Pokemon.create!(species: name.capitalize, dex_number: dex_number)
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

# # Item.destroy_all
# # ActiveRecord::Base.connection.reset_pk_sequence!('item')

# # items = JSON.parse(body)["results"].map { |r| r["name"] }
# # items.each do |name, description|
# #   Item.find_or_create_by!(name: name, description: description)
# # end



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

# json_path = Rails.root.join('db', 'JSON', 'data', 'types.json')
# types = JSON.parse(File.read(json_path))
# types.each do |type|
#   Type.create!(name: type)
# end

# json_path = Rails.root.join('db', 'scorched-silver-encounters.json')
# area_data  = JSON.parse(File.read(json_path))

# AreaPokemon.delete_all
# ActiveRecord::Base.connection.reset_pk_sequence!('area_pokemon')

# area_data.each do |area_name, method_data|
#   area = Area.find_or_create_by!(name: area_name, game_id: 25)
#   method_data.each do |method_name, encounters|
#     encounters.each do |encounter|
#       AreaPokemon.create!(
#         area_id: area.id,
#         encounter_method: method_name,
#         game_pokemon: GamePokemon.find(Pokemon.find_by(species: encounter['species'].id)),
#         min_level: encounter['min_level'],
#         max_level: encounter['max_level'],
#         encounter_rate: encounter['encounter_rate']
#       )
#     end
#   end
# end



Game.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('games')
ActiveRecord::Base.connection.reset_pk_sequence!('moves')
ActiveRecord::Base.connection.reset_pk_sequence!('game_pokemon')
ActiveRecord::Base.connection.reset_pk_sequence!('pokemon_moves')
ActiveRecord::Base.connection.reset_pk_sequence!('splits')
ActiveRecord::Base.connection.reset_pk_sequence!('areas')
ActiveRecord::Base.connection.reset_pk_sequence!('nuzlockes')
ActiveRecord::Base.connection.reset_pk_sequence!('attempts')
ActiveRecord::Base.connection.reset_pk_sequence!('attempt_pokemon')
ActiveRecord::Base.connection.reset_pk_sequence!('trainers')
ActiveRecord::Base.connection.reset_pk_sequence!('trainer_pokemon')

json_path = Rails.root.join('db', 'JSON', 'games', 'sterling-silver.json')
game = JSON.parse(File.read(json_path))

sterling_silver = Game.find_or_create_by!(title: 'sterling-silver')

game["moves"].each do |move_data|
  Move.create!(name: move_data["name"],
               game: sterling_silver, 
               effect: move_data["effect"], 
               category: move_data["category"], 
               power: move_data["power"], 
               type: Type.find_by(name: move_data["type"]), 
               accuracy: move_data["accuracy"], 
               pp: move_data["pp"], 
               effect_chance: move_data["effect_chance"], 
               targets: move_data["targets"], 
               priority: move_data["priority"])
end

game["pokemon"].each do |species, data|
  pokemon = Pokemon.find_by(species: species)
  puts(pokemon.species)
  game_pokemon = GamePokemon.create!(
                      pokemon: pokemon,
                      game: sterling_silver, 
                      hp: data["bs"]["hp"], 
                      atk: data["bs"]["atk"], 
                      def: data["bs"]["def"], 
                      spa: data["bs"]["spa"], 
                      spd: data["bs"]["spd"], 
                      spe: data["bs"]["spe"],
                      type_1: Type.find_by(name: data["types"][0]),
                      type_2: Type.find_by(name: data["types"][1]),
                      ability_1: Ability.find_by(name: data["abilities"][0]),
                      ability_2: Ability.find_by(name: data["abilities"][1]))
  data["learnset_info"]["learnset"].each do |level, move_name|
    PokemonMove.create!(game_pokemon: game_pokemon,
                        method: 'Level',
                        level: level,
                        move: Move.find_by(name: move_name))
  end
  data["learnset_info"]["tms"].each do |move_name|
    PokemonMove.create!(game_pokemon: game_pokemon,
                        method: 'TM',
                        move: Move.find_by(name: move_name))
  end
end


game["splits"].each do |split_data|
  split = Split.create(name: split_data['name'], 
                       game: sterling_silver, 
                       level_cap: split_data['level_cap'], 
                       position: split_data['position'])
  split_data['areas'].each do |area_data|
    area = Area.create!(name: area_data['name'], 
                        game: sterling_silver)

    Array(area_data['trainers']).each do |trainer_data|
      trainer = Trainer.create!({
        name: trainer_data['name'], 
        area: area, 
        position: trainer_data['position'], 
        trainer_type: trainer_data['trainer_type'], 
        split: split,
        notes: trainer_data['notes'],
        starter_requirement: trainer_data['starter_requirement'],
        sprite_url: trainer_data['sprite_url']})

      trainer_data['trainer_pokemon'].each do |pokemon_data|
        pokemon = Pokemon.find_by(species: pokemon_data['species'])

        TrainerPokemon.create!({ 
          trainer: trainer, 
          game_pokemon: GamePokemon.find_by(pokemon_id: pokemon.id) ,
          level: pokemon_data['level'],
          position: pokemon_data['position'],
          move1: Move.find_by(name: pokemon_data['moves'][0]), 
          move2: Move.find_by(name: pokemon_data['moves'][1]), 
          move3: Move.find_by(name: pokemon_data['moves'][2]), 
          move4: Move.find_by(name: pokemon_data['moves'][3]), 
          item: Item.find_by(name: pokemon_data['item']) })
      end
    end
    Array(area_data['area_pokemon']).each do |area_pokemon|
      pokemon = Pokemon.find_by(species: area_pokemon['species'])
      game_pokemon = GamePokemon.find_by(pokemon_id: pokemon.id)
      AreaPokemon.create!(
        area: area,
        encounter_method: area_pokemon['method'],
        game_pokemon: game_pokemon,
        min_level: area_pokemon['min_level'],
        max_level: area_pokemon['max_level'],
        encounter_rate: area_pokemon['rate'])
    end
  end
end





