module TrainerPokemonHelper
  def display_item(trainer_pokemon)
    if trainer_pokemon.item.present?
      image_tag item_sprite_url(trainer_pokemon), alt: trainer_pokemon.item.pretty_name, title: trainer_pokemon.item.pretty_name
    else
      content_tag(:p, 'No Item')
    end
  end

  private

  def item_sprite_url(trainer_pokemon)
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/#{trainer_pokemon.item.name}.png"
  end
end
