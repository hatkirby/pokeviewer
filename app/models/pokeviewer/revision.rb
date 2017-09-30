require 'active_record/diff'

module Pokeviewer
  class Revision < ApplicationRecord
    include ActiveRecord::Diff

    diff :nickname, :level, :hp, :attack, :defense,
      :special_attack, :special_defense, :speed, :coolness, :beauty, :cuteness,
      :smartness, :toughness, :sheen, :hold_item, :move_1_id, :move_2_id,
      :move_3_id, :move_4_id, :move_1_pp_bonuses, :move_2_pp_bonuses,
      :move_3_pp_bonuses, :move_4_pp_bonuses, :cool_ribbons, :beauty_ribbons,
      :cute_ribbons, :smart_ribbons, :tough_ribbons, :champion_ribbon,
      :winning_ribbon, :victory_ribbon, :artist_ribbon, :effort_ribbon,
      :marine_ribbon, :land_ribbon, :sky_ribbon, :country_ribbon,
      :national_ribbon, :earth_ribbon, :world_ribbon

    belongs_to :pokemon
    acts_as_sequenced scope: :pokemon_id

    validates :nickname, presence: true

    validates :experience, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :level, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :hp, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :attack, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :defense, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :special_attack, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :special_defense, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :speed, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :coolness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :beauty, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :cuteness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :smartness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :toughness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :sheen, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    belongs_to :move_1, class_name: "Move"
    belongs_to :move_2, class_name: "Move", optional: true
    belongs_to :move_3, class_name: "Move", optional: true
    belongs_to :move_4, class_name: "Move", optional: true

    validates :move_1_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :move_2_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :move_3_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :move_4_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :cool_ribbons, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 4,
        only_integer: true}

    validates :beauty_ribbons, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 4,
        only_integer: true}

    validates :cute_ribbons, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 4,
        only_integer: true}

    validates :smart_ribbons, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 4,
        only_integer: true}

    validates :tough_ribbons, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 4,
        only_integer: true}

    def ribbons
      result = []

      if cool_ribbons >= 1
        result << {
          filename: "cool-ribbon.png",
          name: "Cool Ribbon",
          description: "Cool Contest Normal Rank Winner!"
        }
      end

      if cool_ribbons >= 2
        result << {
          filename: "cool-ribbon-super.png",
          name: "Cool Ribbon Super",
          description: "Cool Contest Super Rank Winner!"
        }
      end

      if cool_ribbons >= 3
        result << {
          filename: "cool-ribbon-hyper.png",
          name: "Cool Ribbon Hyper",
          description: "Cool Contest Hyper Rank Winner!"
        }
      end

      if cool_ribbons == 4
        result << {
          filename: "cool-ribbon-master.png",
          name: "Cool Ribbon Master",
          description: "Cool Contest Master Rank Winner!"
        }
      end

      if beauty_ribbons >= 1
        result << {
          filename: "beauty-ribbon.png",
          name: "Beauty Ribbon",
          description: "Beauty Contest Normal Rank Winner!"
        }
      end

      if beauty_ribbons >= 2
        result << {
          filename: "beauty-ribbon-super.png",
          name: "Beauty Ribbon Super",
          description: "Beauty Contest Super Rank Winner!"
        }
      end

      if beauty_ribbons >= 3
        result << {
          filename: "beauty-ribbon-hyper.png",
          name: "Beauty Ribbon Hyper",
          description: "Beauty Contest Hyper Rank Winner!"
        }
      end

      if beauty_ribbons == 4
        result << {
          filename: "beauty-ribbon-master.png",
          name: "Beauty Ribbon Master",
          description: "Beauty Contest Master Rank Winner!"
        }
      end

      if cute_ribbons >= 1
        result << {
          filename: "cute-ribbon.png",
          name: "Cute Ribbon",
          description: "Cute Contest Normal Rank Winner!"
        }
      end

      if cute_ribbons >= 2
        result << {
          filename: "cute-ribbon-super.png",
          name: "Cute Ribbon Super",
          description: "Cute Contest Super Rank Winner!"
        }
      end

      if cute_ribbons >= 3
        result << {
          filename: "cute-ribbon-hyper.png",
          name: "Cute Ribbon Hyper",
          description: "Cute Contest Hyper Rank Winner!"
        }
      end

      if cute_ribbons == 4
        result << {
          filename: "cute-ribbon-master.png",
          name: "Cute Ribbon Master",
          description: "Cute Contest Master Rank Winner!"
        }
      end

      if smart_ribbons >= 1
        result << {
          filename: "smart-ribbon.png",
          name: "Smart Ribbon",
          description: "Smart Contest Normal Rank Winner!"
        }
      end

      if smart_ribbons >= 2
        result << {
          filename: "smart-ribbon-super.png",
          name: "Smart Ribbon Super",
          description: "Smart Contest Super Rank Winner!"
        }
      end

      if smart_ribbons >= 3
        result << {
          filename: "smart-ribbon-hyper.png",
          name: "Smart Ribbon Hyper",
          description: "Smart Contest Hyper Rank Winner!"
        }
      end

      if smart_ribbons == 4
        result << {
          filename: "smart-ribbon-master.png",
          name: "Smart Ribbon Master",
          description: "Smart Contest Master Rank Winner!"
        }
      end

      if tough_ribbons >= 1
        result << {
          filename: "tough-ribbon.png",
          name: "Tough Ribbon",
          description: "Tough Contest Normal Rank Winner!"
        }
      end

      if tough_ribbons >= 2
        result << {
          filename: "tough-ribbon-super.png",
          name: "Tough Ribbon Super",
          description: "Tough Contest Super Rank Winner!"
        }
      end

      if tough_ribbons >= 3
        result << {
          filename: "tough-ribbon-hyper.png",
          name: "Tough Ribbon Hyper",
          description: "Tough Contest Hyper Rank Winner!"
        }
      end

      if tough_ribbons == 4
        result << {
          filename: "tough-ribbon-master.png",
          name: "Tough Ribbon Master",
          description: "Tough Contest Master Rank Winner!"
        }
      end

      if champion_ribbon
        result << {
          filename: "champion-ribbon.png",
          name: "Champion Ribbon",
          description: "Champion-beating, Hall of Fame Member Ribbon"
        }
      end

      if winning_ribbon
        result << {
          filename: "winning-ribbon.png",
          name: "Winning Ribbon",
          description: "Ribbon for clearing LV50 at the Battle Tower."
        }
      end

      if victory_ribbon
        result << {
          filename: "victory-ribbon.png",
          name: "Victory Ribbon",
          description: "Won for clearing LV100 at the Battle Tower."
        }
      end

      if artist_ribbon
        result << {
          filename: "artist-ribbon.png",
          name: "Artist Ribbon",
          description: "Ribbon for being chosen as a super sketch model."
        }
      end

      if effort_ribbon
        result << {
          filename: "effort-ribbon.png",
          name: "Effort Ribbon",
          description: "Ribbon awarded for being a hard worker."
        }
      end

      if marine_ribbon
        result << {
          filename: "marine-ribbon.png",
          name: "Marine Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:marine_ribbon)
        }
      end

      if land_ribbon
        result << {
          filename: "land-ribbon.png",
          name: "Land Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:land_ribbon)
        }
      end

      if sky_ribbon
        result << {
          filename: "sky-ribbon.png",
          name: "Sky Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:sky_ribbon)
        }
      end

      if country_ribbon
        result << {
          filename: "country-ribbon.png",
          name: "Country Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:country_ribbon)
        }
      end

      if national_ribbon
        result << {
          filename: "national-ribbon.png",
          name: "National Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:national_ribbon)
        }
      end

      if earth_ribbon
        result << {
          filename: "earth-ribbon.png",
          name: "Earth Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:earth_ribbon)
        }
      end

      if world_ribbon
        result << {
          filename: "world-ribbon.png",
          name: "World Ribbon",
          description: pokemon.trainer.gift_ribbon_description(:world_ribbon)
        }
      end

      result
    end
  end
end
