puts 'Resetting seed state...'

puts 'Destroying existing games...'
Game.destroy_all

puts 'Resetting primary key sequences:'
%w[
  games
  moves
  game_pokemon
  pokemon_moves
  splits
  areas
  nuzlockes
  attempts
  attempt_pokemon
  trainers
  trainer_pokemon
].each do |table_name|
  ActiveRecord::Base.connection.reset_pk_sequence!(table_name)
  puts "  - #{table_name}"
end
