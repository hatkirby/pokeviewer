module Pokeviewer
  class Move < ApplicationRecord
    has_many :revision_moves
    has_many :revisions, through: :revision_moves

    validates :name, presence: true, uniqueness: true
    validates :pp, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }
  end
end
