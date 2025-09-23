require 'json'

def import_game_from_json(json_path, create_pokemon: false, custom_dex_base: 10_000)
  puts "Importing game data from #{json_path}..."
  data = JSON.parse(File.read(json_path))
  title = data['title'] || File.basename(json_path, File.extname(json_path))
  game = Game.find_or_create_by!(title: title)
  game_rec = game

  puts "Preparing data for '#{game.title}' (id: #{game.id})"

  move_count = 0

  Array(data["moves"]).each do |move_data|
    Move.create!(name: move_data["name"],
                 game: game,
                 effect: move_data["effect"],
                 category: move_data["category"],
                 power: move_data["power"],
                 type: Type.find_by(name: move_data["type"]),
                 accuracy: move_data["accuracy"],
                 pp: move_data["pp"],
                 effect_chance: move_data["effect_chance"],
                 targets: move_data["targets"],
                 priority: move_data["priority"])
    move_count += 1
  end

  puts "  Imported #{move_count} moves"

  created_pokemon_count = 0
  updated_pokemon_count = 0
  game_pokemon_count = 0
  levelup_move_count = 0
  tm_move_count = 0

  Array(data["pokemon"]).each do |species, p_data|
    pokemon = Pokemon.find_by(species: species)
    if create_pokemon
      if !pokemon
        next_dex = (Pokemon.where("dex_number >= ?", custom_dex_base).maximum(:dex_number) || (custom_dex_base - 1)) + 1
        pokemon = Pokemon.create!(species: species, dex_number: next_dex)
        created_pokemon_count += 1
      elsif pokemon.dex_number.nil?
        pokemon.update!(dex_number: (Pokemon.where("dex_number >= ?", custom_dex_base).maximum(:dex_number) || (custom_dex_base - 1)) + 1)
        updated_pokemon_count += 1
      end
    end

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
    game_pokemon_count += 1

    if p_data["learnset_info"]
      Array(p_data["learnset_info"]["learnset"]).each do |level, move_name|
        PokemonMove.create!(game_pokemon: game_pokemon,
                            method: 'Level',
                            level: level,
                            move: Move.find_by(name: move_name))
        levelup_move_count += 1
      end
      Array(p_data["learnset_info"]["tms"]).each do |move_name|
        PokemonMove.create!(game_pokemon: game_pokemon,
                            method: 'TM',
                            move: Move.find_by(name: move_name))
        tm_move_count += 1
      end
    end
  end

  puts "  Linked #{game_pokemon_count} game pokemon"
  puts "  Created #{created_pokemon_count} new pokemon" if created_pokemon_count.positive?
  puts "  Updated #{updated_pokemon_count} pokemon dex numbers" if updated_pokemon_count.positive?
  puts "  Added #{levelup_move_count} level-up moves and #{tm_move_count} TM moves"

  split_count = 0
  area_count = 0
  trainer_count = 0
  trainer_pokemon_count = 0
  area_pokemon_count = 0

  Array(data["splits"]).each do |split_data|
    split = Split.create!(name: split_data['name'],
                          game: game_rec,
                          level_cap: split_data['level_cap'],
                          position: split_data['position'])
    split_count += 1
    Array(split_data['areas']).each do |area_data|
      area = Area.create!(name: area_data['name'], game: game_rec)
      area_count += 1

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
        trainer_count += 1

        Array(trainer_data['trainer_pokemon']).each do |tp|
          base = Pokemon.find_by(species: tp['species'])
          TrainerPokemon.create!({
            trainer: trainer,
            game_pokemon: GamePokemon.find_by(pokemon_id: base.id, game_id: game_rec.id),
            level: tp['level'],
            position: tp['position'],
            move1: Move.find_by(name: tp['moves'][0]),
            move2: Move.find_by(name: tp['moves'][1]),
            move3: Move.find_by(name: tp['moves'][2]),
            move4: Move.find_by(name: tp['moves'][3]),
            item: Item.find_by(name: tp['item'])
          })
          trainer_pokemon_count += 1
        end
      end

      Array(area_data['area_pokemon']).each do |ap|
        base = Pokemon.find_by(species: ap['species'])
        gp = base && GamePokemon.find_by(pokemon_id: base.id, game_id: game_rec.id)
        next unless gp

        AreaPokemon.create!(
          area: area,
          encounter_method: ap['method'],
          game_pokemon: gp,
          min_level: ap['min_level'],
          max_level: ap['max_level'],
          encounter_rate: ap['rate']
        )
        area_pokemon_count += 1
      end
    end
  end

  puts "  Added #{split_count} splits, #{area_count} areas"
  puts "  Created #{trainer_count} trainers with #{trainer_pokemon_count} pokemon"
  puts "  Registered #{area_pokemon_count} area encounters"
  puts "Finished importing '#{game.title}'."
end
