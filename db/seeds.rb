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

def import_game_from_json(json_path, title, create_pokemon: false, custom_dex_base: 10_000)
  data = JSON.parse(File.read(json_path))
  game_rec = Game.find_or_create_by!(title: title)

  # Moves (scoped to game)
  Array(data["moves"]).each do |move_data|
    Move.create!(name: move_data["name"],
                 game: game_rec,
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

  # Pokemon + GamePokemon
  Array(data["pokemon"]).each do |species, p_data|
    # Find or create base Pokemon
    pokemon = Pokemon.find_by(species: species)
    if create_pokemon
      if !pokemon
        # Assign a custom dex number for non-vanilla species
        next_dex = (Pokemon.where("dex_number >= ?", custom_dex_base).maximum(:dex_number) || (custom_dex_base - 1)) + 1
        pokemon = Pokemon.create!(species: species, dex_number: next_dex)
      elsif pokemon.dex_number.nil?
        pokemon.update!(dex_number: (Pokemon.where("dex_number >= ?", custom_dex_base).maximum(:dex_number) || (custom_dex_base - 1)) + 1)
      end
    end

    # If still missing, skip linking to avoid inconsistent state (e.g., missing vanilla mons)
    next unless pokemon

    game_pokemon = GamePokemon.create!(
      pokemon: pokemon,
      game: game_rec,
      hp: p_data["bs"]["hp"],
      atk: p_data["bs"]["atk"],
      def: p_data["bs"]["def"],
      spa: p_data["bs"]["spa"],
      spd: p_data["bs"]["spd"],
      spe: p_data["bs"]["spe"],
      type_1: Type.find_by(name: p_data["types"][0]),
      type_2: Type.find_by(name: p_data["types"][1]),
      ability_1: Ability.find_by(name: p_data["abilities"][0]),
      ability_2: Ability.find_by(name: p_data["abilities"][1])
    )

    # Learnsets (optional)
    if p_data["learnset_info"]
      Array(p_data["learnset_info"]["learnset"]).each do |level, move_name|
        PokemonMove.create!(game_pokemon: game_pokemon,
                            method: 'Level',
                            level: level,
                            move: Move.find_by(name: move_name))
      end
      Array(p_data["learnset_info"]["tms"]).each do |move_name|
        PokemonMove.create!(game_pokemon: game_pokemon,
                            method: 'TM',
                            move: Move.find_by(name: move_name))
      end
    end
  end

  # World data (splits/areas/trainers/encounters)
  Array(data["splits"]).each do |split_data|
    split = Split.create!(name: split_data['name'],
                          game: game_rec,
                          level_cap: split_data['level_cap'],
                          position: split_data['position'])
    Array(split_data['areas']).each do |area_data|
      area = Area.create!(name: area_data['name'], game: game_rec)

      Array(area_data['trainers']).each do |trainer_data|
        trainer = Trainer.create!({
          name: trainer_data['name'],
          area: area,
          position: trainer_data['position'],
          trainer_type: trainer_data['trainer_type'],
          split: split,
          notes: trainer_data['notes'],
          starter_requirement: trainer_data['starter_requirement'],
          sprite_url: trainer_data['sprite_url']
        })

        Array(trainer_data['trainer_pokemon']).each do |tp|
          base = Pokemon.find_by(species: tp['species'])
          TrainerPokemon.create!({
            trainer: trainer,
            game_pokemon: GamePokemon.find_by(pokemon_id: base.id),
            level: tp['level'],
            position: tp['position'],
            move1: Move.find_by(name: tp['moves'][0]),
            move2: Move.find_by(name: tp['moves'][1]),
            move3: Move.find_by(name: tp['moves'][2]),
            move4: Move.find_by(name: tp['moves'][3]),
            item: Item.find_by(name: tp['item'])
          })
        end
      end

      Array(area_data['area_pokemon']).each do |ap|
        base = Pokemon.find_by(species: ap['species'])
        gp = base && GamePokemon.find_by(pokemon_id: base.id)
        next unless gp

        AreaPokemon.create!(
          area: area,
          encounter_method: ap['method'],
          game_pokemon: gp,
          min_level: ap['min_level'],
          max_level: ap['max_level'],
          encounter_rate: ap['rate']
        )
      end
    end
  end
end

# Import Sterling Silver (expects base Pokémon already present; doesn't create new)
import_game_from_json(
  Rails.root.join('db', 'JSON', 'games', 'sterling-silver.json'),
  'sterling-silver',
  create_pokemon: false
)

# Import Monster Hunter Emerald (creates species with custom dex numbers starting at 10000)
import_game_from_json(
  Rails.root.join('db', 'JSON', 'games', 'mhe.json'),
  'mhe',
  create_pokemon: true,
  custom_dex_base: 10_000
)

