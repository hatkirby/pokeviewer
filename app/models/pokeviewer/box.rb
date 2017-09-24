module Pokeviewer
  class Box < ApplicationRecord
    belongs_to :trainer

    validates :name, presence: true

    validates :number, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than: 14,
        only_integer: true },
      uniqueness: { scope: :trainer_id }

    def contents
      pokes = trainer.pokemon.where(box: number).order("slot ASC").to_a

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
  end
end
