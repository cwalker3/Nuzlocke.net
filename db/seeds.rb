# Run all seed scripts located in db/seeds/*.rb in sorted order
seed_dir = File.join(__dir__, 'seeds')

puts 'Starting database seed load...'

Dir[File.join(seed_dir, '*.rb')].sort.each do |seed_file|
  puts "Loading seed: #{File.basename(seed_file)}"
  load seed_file
end

puts 'All seed files loaded.'
