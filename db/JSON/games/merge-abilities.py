# merge_pokedex_abilities.py

import json

# 1) Load your existing pokedex JSON (replace with your actual filename)
with open('sterling-silver.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

# 2) Load your abilities map (replace if named differently)
with open('abilities.json', 'r', encoding='utf-8') as f:
    abilities_map = json.load(f)

# 3) Insert abilities into each Pokémon under the "pokemon" key
for name, entry in data.get('pokemon', {}).items():
    entry['abilities'] = abilities_map.get(name, [])

# 4) Write out the enriched JSON
with open('pokedex_with_abilities.json', 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print(f"Inserted abilities for {len(data.get('pokemon', {}))} Pokémon entries.")
