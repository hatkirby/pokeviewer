module Pokeviewer
  class Move < ApplicationRecord
    extend Enumerize

    has_many :revision_moves
    has_many :revisions, through: :revision_moves

    validates :name, presence: true, uniqueness: true

    validates :pp, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :move_type, presence: true
    enumerize :move_type, in: [:normal, :fighting, :flying, :poison, :ground,
      :rock, :bug, :ghost, :steel, :mystery, :fire, :water, :grass, :electric,
      :psychic, :ice, :dragon, :dark], predicates: true

    validates :rs_description, presence: true
    validates :frlg_description, presence: true

    def description(game)
      if game == :emerald and not emerald_description.nil?
        emerald_description
      elsif game == :firered or game == :leafgreen
        frlg_description
      else
        rs_description
      end
    end
  end
end
