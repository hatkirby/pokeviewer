module Pokeviewer
  class Trainer < ApplicationRecord
    extend Enumerize

    has_many :pokemon, dependent: :nullify

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

    validates :box_1_name, presence: true
    validates :box_2_name, presence: true
    validates :box_3_name, presence: true
    validates :box_4_name, presence: true
    validates :box_5_name, presence: true
    validates :box_6_name, presence: true
    validates :box_7_name, presence: true
    validates :box_8_name, presence: true
    validates :box_9_name, presence: true
    validates :box_10_name, presence: true
    validates :box_11_name, presence: true
    validates :box_12_name, presence: true
    validates :box_13_name, presence: true
    validates :box_14_name, presence: true

    def party
      pokemon.party.includes(revisions: [:species])
    end

    def box(n)
      pokemon.box(n).includes(revisions: [:species])
    end

    def box_name(n)
      if n > 0 and n <= 14
        send "box_#{n}_name".intern
      else
        nil
      end
    end

    def box_contents(n)
      pokes = box(n).to_a

      result = []
      (0..29).each do |i|
        if pokes.empty? or (pokes.first.slot == i)
          result << pokes.shift
        else
          result << nil
        end
      end

      result
    end

    def boxes
      (1..14).map { |n| {
        name: box_name(n),
        pokemon: box_contents(n)
      }}
    end

    def display_number
      number.to_s.rjust(5, '0')
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
