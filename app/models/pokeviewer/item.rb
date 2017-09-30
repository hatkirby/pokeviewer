module Pokeviewer
  class Item < ApplicationRecord
    validates :name, presence: true

    belongs_to :move, optional: true
    validates :move, presence: true, if: :tm?

    validates :rs_description, presence: true, unless: :tm?
    validates :frlg_description, presence: true, unless: :tm?

    def description(game)
      if game == :emerald
        if not emerald_description.nil?
          emerald_description
        elsif not rs_description.nil?
          rs_description
        else
          move.description game
        end
      elsif game == :firered or game == :leafgreen
        if not frlg_description.nil?
          frlg_description
        else
          move.description game
        end
      else
        if not rs_description.nil?
          rs_description
        else
          move.description game
        end
      end
    end

    def icon_path
      if tm?
        "pokeviewer/items/tms/#{move.move_type}.png"
      else
        "pokeviewer/items/#{id}.png"
      end
    end
  end
end
