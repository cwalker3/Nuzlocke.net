namespace :sprites do
  namespace :mhe do
    # Renames/copies MHE sprites to public/pokemon/<dex>.png
    # Usage: bin/rails sprites:mhe:rename
    task rename: :environment do
      require 'fileutils'

      game = Game.find_by(title: 'mhe')
      abort 'Game "mhe" not found. Seed first.' unless game

      src_dir = Rails.root.join('app', 'assets', 'images', 'mhe')
      out_pokemon = Rails.root.join('public', 'pokemon')
      out_icons   = Rails.root.join('public', 'box-icons')
      FileUtils.mkdir_p(out_pokemon)
      FileUtils.mkdir_p(out_icons)

      # Known filename aliases that don't match a simple slug
      aliases = {
        # A
        'Abiogladius' => 'a-biogladus',
        'Acidic Glavenus' => 'aglavenus',
        'Abyssal Lagiacrus' => 'alagiacrus',
        'Azure Rathalos' => 'arathalos',
        'Aurora Somnacanth' => 'asomnacnth',
        # B
        'Black Gravios' => 'b-gravios',
        'Breeding Hypnocatrice' => 'b-hypnoctr',
        'Brute Tigrex' => 'b-tigrex',
        'Bahala' => 'bahara',
        'Balahara' => 'balahara',
        'Blood Orange Bishaten' => 'bobishaten',
        'Brachid' => 'brachid',
        # C
        'Coral Pukei Pukei' => 'c-pukei',
        'Chaotic Gore Magala' => 'cgoremagala',
        'Crimson Qurupeco' => 'cqurupeco',
        # D
        'Daimyo Hermitaur' => 'd-hermitaur',
        'Dire Miralis' => 'd-miralis',
        'Desert Seltas' => 'd-seltas',
        'Desert Seltas Queen' => 'ds.queen',
        # E
        'Emerald Congalala' => 'econgalala',
        'Ebony Odogaron' => 'eodogaron',
        # F
        'Fulgur Anjanath' => 'fanjanath',
        # G
        'Glacial Agnaktor' => 'gagnaktor',
        'Green Plesioth' => 'gplesioth',
        'Gold Rathian' => 'grathian',
        'Great Girros' => 'greatgiros',
        'Great Jagras' => 'greatjagrs',
        'Great Wroggi' => 'greatwrogi',
        'Green Nargacuga' => 'gnargacuga',
        # H
        'Hypnocatrice' => 'hypnoctrce',
        # I
        'Ivory Lagiacrus' => 'i-lagiacrus',
        # J
        'Jade Barroth' => 'jbarroth',
        # K
        'Kelbi ♂' => 'kelbi-m',
        'Kelbi ♀' => 'kelbi-f',
        # L
        'Lucent Nargacuga' => 'lnargacuga',
        # M
        'Molten Tigrex' => 'm-tigrex',
        # O
        'Oroshi Kirin' => 'o-kirin',
        # P
        'Purple Gypceros' => 'p-gypceros',
        'Plum Daimyo Hermitaur' => 'phermitar',
        'Purple Ludroth' => 'pludroth',
        'Pyre Rakna Kadaki' => 'pr.kadaki',
        'Pink Rathian' => 'prathian',
        # Q
        # R
        'Rakna Kadaki' => 'r-kadaki',
        'Red Khezu' => 'r-khezu',
        'Red Lavasioth' => 'r-lavasioth',
        'Royal Ludroth' => 'r-ludroth',
        'Ruby Basarios' => 'rbasarios',
        'Rust Duramboros' => 'rdurmbros',
        # S
        'Shrouded Nerscylla' => 's-nercylla',
        'Stygian Zinogre' => 's-zinogre',
        'Seltas Queen' => 'squeen',
        'Silver Rathalos' => 'srathalos',
        'Shagaru Magala' => 'shagarum',
        'Shakalaka King' => 'king-shaka',
        'Shogun Ceanataur' => 'shogun',
        'Silver Hypnocatrice' => 'shypnoctr',
        # T
        'Terra Shogun Ceanataur' => 't-shogun',
        'Tobi Kadachi' => 'tkadachi',
        'Tidal Najarala' => 'tnajarala',
        # V
        'Vespoid Queen' => 'vesp-queen',
        'Viper Tobi Kadachi' => 'v-kadachi',
        'Violet Mizutsune' => 'v-mizutsune',
        # W
        'White Monoblos' => 'w-monoblos',
        # Misc additional fixes
        'Goss Harag' => 'goss-harag',
        'Thunderbug+' => 'thundrbug',
        'Dracophage Bug' => 'dracobug',
        'Dracophage Bug+' => 'dracophbug',
        'AptonothEX' => 'aptonothex',
        'Shakalaka' => 'shakalala',
        'Pukei Pukei' => 'pukeipukei',
        'Rathling' => 'rathling',
        'Velocidrome' => 'velocidrom'
      }

      def slugify(name)
        s = name.downcase
        s = s.gsub(/[♀]/, 'f').gsub(/[♂]/, 'm')
        s = s.gsub('+', 'plus')
        s = s.gsub(/[^a-z0-9]+/, '-')
        s = s.gsub(/-+/, '-').gsub(/^-|-$/,'')
        s
      end

      missing_sprite = []
      renamed = 0

      game.game_pokemon.includes(:pokemon).find_each do |gp|
        species = gp.pokemon.species
        dex     = gp.pokemon.dex_number
        unless dex
          puts "Skipping #{species}: no dex_number"
          next
        end

        candidates = []
        if (alias_name = aliases[species])
          candidates << src_dir.join("#{alias_name}.png")
          candidates << src_dir.join("#{alias_name}.gif")
        end
        slug = slugify(species)
        candidates << src_dir.join("#{slug}.png")
        candidates << src_dir.join("#{slug}.gif")

        src = candidates.find { |p| File.exist?(p) }
        unless src
          missing_sprite << species
          next
        end

        # Copy to sprite output; duplicate to icon if no dedicated icon exists
        dest_sprite = out_pokemon.join("#{dex}.png")
        FileUtils.cp(src, dest_sprite)

        icon_src = src_dir.join("icons", File.basename(src))
        dest_icon = out_icons.join("#{dex}.png")
        if File.exist?(icon_src)
          FileUtils.cp(icon_src, dest_icon)
        else
          FileUtils.cp(src, dest_icon)
        end

        puts "Mapped #{species.ljust(24)} -> #{dest_sprite.relative_path_from(Rails.root)}"
        renamed += 1
      end

      if missing_sprite.any?
        puts "\nMissing source sprite for:" \
             "\n - " + missing_sprite.sort.join("\n - ")
      end
      puts "\nDone. Wrote #{renamed} sprite(s)."
    end
  end
end
