class AddConstraints < ActiveRecord::Migration[8.0]
  def change
    # 1. Fix attempt_items: rename items_id → item_id, add the missing attempt FK
remove_index :attempt_items, name: 'index_attempt_items_on_items_id'
rename_column :attempt_items, :items_id, :item_id
add_index    :attempt_items, :item_id

# 2. Avoid STI collision on trainers.type
rename_column :trainers, :type, :trainer_type

# 3. Make hp_iv an integer (all other IVs are already integers)
change_column :attempt_pokemon, :hp_iv, :integer, using: 'hp_iv::integer'

# 4. Enforce NOT NULL on area_pokemon foreign-keys
change_column_null :area_pokemon, :area_id,    false
change_column_null :area_pokemon, :pokemon_id, false

# 5. Prevent duplicate join-table entries
add_index :defeated_trainers, [:attempt_id, :trainer_id], unique: true
add_index :nuzlocke_rules,    [:nuzlocke_id, :rule_id],   unique: true

# 6. Add missing uniqueness constraints on lookup tables
add_index :items,   :name,            unique: true
add_index :items,   :image_file_name, unique: true
add_index :areas,   [:game_id, :name], unique: true
add_index :pokemon, :species,         unique: true
add_index :rules,   :name,            unique: true
  end
end
