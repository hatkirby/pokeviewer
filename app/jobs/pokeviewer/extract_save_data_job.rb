module Pokeviewer
  class ExtractSaveDataJob < ApplicationJob
    queue_as :default

    def perform(args)
      game = Trainer.find_or_initialize_by(
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

      game.box_1_name = args["boxes"].shift
      game.box_2_name = args["boxes"].shift
      game.box_3_name = args["boxes"].shift
      game.box_4_name = args["boxes"].shift
      game.box_5_name = args["boxes"].shift
      game.box_6_name = args["boxes"].shift
      game.box_7_name = args["boxes"].shift
      game.box_8_name = args["boxes"].shift
      game.box_9_name = args["boxes"].shift
      game.box_10_name = args["boxes"].shift
      game.box_11_name = args["boxes"].shift
      game.box_12_name = args["boxes"].shift
      game.box_13_name = args["boxes"].shift
      game.box_14_name = args["boxes"].shift

      if args.key? "marineRibbon"
        game.marine_ribbon_id = args["marineRibbon"]
      end

      if args.key? "landRibbon"
        game.land_ribbon_id = args["landRibbon"]
      end

      if args.key? "skyRibbon"
        game.sky_ribbon_id = args["skyRibbon"]
      end

      if args.key? "countryRibbon"
        game.country_ribbon_id = args["countryRibbon"]
      end

      if args.key? "nationalRibbon"
        game.national_ribbon_id = args["nationalRibbon"]
      end

      if args.key? "earthRibbon"
        game.earth_ribbon_id = args["earthRibbon"]
      end

      if args.key? "worldRibbon"
        game.world_ribbon_id = args["worldRibbon"]
      end

      game.save! if game.new_record? or game.changed?

      game.pokemon.clear

      args["pokemon"].each do |param|
        pk = Pokemon.find_or_create_by!(key: param["key"]) do |r|
          r.species_id = param["species"]
          r.ot_name = param["otName"]
          r.ot_number = param["otId"]
          r.ot_gender = param["otGender"]

          if param["orre"]
            r.met_type = :orre
          elsif param["metLevel"] == 0
            r.met_type = :hatched
            r.location_id = param["metLocation"]
          elsif param["metLocation"] == 254
            r.met_type = :npc_trade
          elsif param["metLocation"] == 255
            r.met_type = :fateful_encounter
            r.met_level = param["metLevel"]
          else
            r.met_type = :normal
            r.met_level = param["metLevel"]
            r.location_id = param["metLocation"]
          end

          r.shiny = param["shiny"]
          r.nature = Pokemon.nature.values[param["nature"]]
          r.gender = param["gender"]
          r.second_ability = param["secondAbility"]
          r.pokeball = Pokemon.pokeball.values[param["pokeball"] - 1]

          # Handle Unown form
          if r.species_id == 201
            r.unown_letter = Pokemon.unown_letter.values[param["unownLetter"]]
          end
        end

        pk.trainer = game

        if param["storage"] == "party"
          pk.box = nil
        elsif param["storage"] == "box"
          pk.box = param["box"] + 1
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
        rev.item_id = param["heldItem"] if param.key? "heldItem"
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

        rev.cool_ribbons = param["coolRibbons"]
        rev.beauty_ribbons = param["beautyRibbons"]
        rev.cute_ribbons = param["cuteRibbons"]
        rev.smart_ribbons = param["smartRibbons"]
        rev.tough_ribbons = param["toughRibbons"]
        rev.champion_ribbon = param.fetch "championRibbon", false
        rev.winning_ribbon = param.fetch "winningRibbon", false
        rev.victory_ribbon = param.fetch "victoryRibbon", false
        rev.artist_ribbon = param.fetch "artistRibbon", false
        rev.effort_ribbon = param.fetch "effortRibbon", false
        rev.marine_ribbon = param.fetch "marineRibbon", false
        rev.land_ribbon = param.fetch "landRibbon", false
        rev.sky_ribbon = param.fetch "skyRibbon", false
        rev.country_ribbon = param.fetch "countryRibbon", false
        rev.national_ribbon = param.fetch "nationalRibbon", false
        rev.earth_ribbon = param.fetch "earthRibbon", false
        rev.world_ribbon = param.fetch "worldRibbon", false

        if pk.revisions.empty? or rev.diff?(pk.revisions.last)
          rev.save!
        end
      end
    end
  end
end
