module Pokeviewer
  class Trainer < ApplicationRecord
    extend Enumerize

    has_many :pokemon, dependent: :nullify
    has_many :boxes, -> { order("number ASC") }, dependent: :destroy

    validates :number, presence: true,
      numericality: { greater_than_or_equal_to: 0, only_integer: true }

    validates :name, presence: true, uniqueness: {
      scope: :number,
      message: "and number should be pairwise unique" }

    validates :game, presence: true
    enumerize :game, in: [:ruby, :sapphire, :firered, :leafgreen, :emerald],
      predicates: true

    belongs_to :marine_ribbon, class_name: "GiftRibbon", optional: true
    belongs_to :land_ribbon, class_name: "GiftRibbon", optional: true
    belongs_to :sky_ribbon, class_name: "GiftRibbon", optional: true
    belongs_to :country_ribbon, class_name: "GiftRibbon", optional: true
    belongs_to :national_ribbon, class_name: "GiftRibbon", optional: true
    belongs_to :earth_ribbon, class_name: "GiftRibbon", optional: true
    belongs_to :world_ribbon, class_name: "GiftRibbon", optional: true

    def display_number
      number.to_s.rjust(5, '0')
    end

    def party
      pokemon.where(box: nil).order("slot ASC")
    end

    def gift_ribbon_description(ribbon)
      gift_ribbon = send ribbon

      if gift_ribbon.nil?
        ""
      else
        gift_ribbon.description
      end
    end
  end
end
