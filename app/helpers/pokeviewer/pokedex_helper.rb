module Pokeviewer
  module PokedexHelper

    def pokedex_table(all_species, trainers)
      final_result = "".html_safe

      all_species.each do |species|
        noted_trainers = species.pokedex_entries.to_a

        if noted_trainers.empty?
          poke_name = "???"
          poke_image = image_tag "pokeviewer/icons/0.png"
        else
          poke_name = species.name
          poke_image = image_tag "pokeviewer/icons/#{species.id}.png"
        end

        result = "".html_safe

        result << tag.th("\##{species.id}")
        result << tag.th(poke_name)
        result << tag.th(poke_image)

        trainers.each do |trainer|
          if !noted_trainers.empty? and noted_trainers.first.trainer_id == trainer.id
            nt = noted_trainers.shift

            if nt.caught
              result << tag.td(trainer.display_number,
                class: ["pkvd-caught", trainer.game])
            else
              result << tag.td(trainer.display_number,
                class: ["pkvd-seen", trainer.game])
            end
          else
            result << tag.td(trainer.display_number, class: "pkvd-unseen")
          end
        end

        result << tag.td(
          species.current_revisions.map {
            |p| link_to p.nickname, p.pokemon }.join(", ").html_safe)

        final_result << tag.tr(result)
      end

      tag.table(final_result, class: "pkvd-table")
    end

  end
end
