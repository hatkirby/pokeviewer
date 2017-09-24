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

    def display_number
      number.to_s.rjust(5, '0')
    end

    def party
      pokemon.where(box: nil).order("slot ASC")
    end
  end
end
