module Pokeviewer
  class ExtractSaveDataJob < ApplicationJob
    queue_as :default

    def perform(args)
      game = Trainer.find_or_create_by!(
        name: args["playerName"],
        number: args["playerId"]) do |r|
          case args["gameId"].to_i
          when 1
            r.game = :ruby
          when 2
            r.game = :sapphire
          when 3
            r.game = :firered
          when 4
            r.game = :leafgreen
          when 5
            r.game = :emerald
          else
            # Invalid, so just leave the field nil
          end
        end

      game.pokemon.clear

      args["pokemon"].each do |param|
        pk = Pokemon.find_or_create_by!(key: param["key"]) do |r|
          r.species_id = param["species"]
          r.ot_name = param["otName"]
          r.ot_number = param["otId"]
          r.ot_gender = param["otGender"]

          if param["metLevel"] == 0
            r.met_type = :hatched
          else
            r.met_type = :normal
            r.met_level = param["metLevel"]
          end

          r.shiny = param["shiny"]
          r.nature = Pokemon.nature.values[param["nature"]]
          r.gender = param["gender"]
          r.second_ability = param["secondAbility"]

          # Handle Unown form
          if r.species_id == 201
            r.unown_letter = Pokemon.unown_letter.values[param["unownLetter"]]
          end
        end

        pk.trainer = game

        if param["storage"] == "party"
          pk.box = nil
        elsif param["storage"] == "box"
          pk.box = param["box"]
        end

        pk.slot = param["slot"]

        pk.save!

        rev = Revision.new(pokemon: pk)
        rev.nickname = param["nickname"]
        rev.experience = param["experience"]
        rev.level = param["level"]
        rev.hp = param["hp"]
        rev.attack = param["attack"]
        rev.defense = param["defense"]
        rev.special_attack = param["spAttack"]
        rev.special_defense = param["spDefense"]
        rev.speed = param["speed"]
        rev.coolness = param["coolness"]
        rev.beauty = param["beauty"]
        rev.cuteness = param["cuteness"]
        rev.smartness = param["smartness"]
        rev.toughness = param["toughness"]
        rev.sheen = param["sheen"]
        rev.hold_item = param["heldItem"]
        rev.move_1_id = param["moves"][0]["id"]
        rev.move_1_pp_bonuses = param["moves"][0]["ppBonuses"]

        if param["moves"].length >= 2
          rev.move_2_id = param["moves"][1]["id"]
          rev.move_2_pp_bonuses = param["moves"][1]["ppBonuses"]
        end

        if param["moves"].length >= 3
          rev.move_3_id = param["moves"][2]["id"]
          rev.move_3_pp_bonuses = param["moves"][2]["ppBonuses"]
        end

        if param["moves"].length == 4
          rev.move_4_id = param["moves"][3]["id"]
          rev.move_4_pp_bonuses = param["moves"][3]["ppBonuses"]
        end

        if pk.revisions.empty? or rev.diff?(pk.revisions.last)
          rev.save!
        end
      end
    end
  end
end
