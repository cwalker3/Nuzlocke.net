game_imports = [
  {
    path: Rails.root.join('db', 'JSON', 'games', 'sterling-silver.json'),
    create_pokemon: false,
    custom_dex_base: 10_000
  }
]

game_imports.each do |config|
  puts "Processing game import config for #{config[:path]}"
  import_game_from_json(
    config[:path],
    create_pokemon: config.fetch(:create_pokemon, false),
    custom_dex_base: config.fetch(:custom_dex_base, 10_000)
  )
end

puts 'Game imports complete.'
