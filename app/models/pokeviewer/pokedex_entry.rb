module Pokeviewer
  class PokedexEntry < ApplicationRecord
    belongs_to :trainer
    belongs_to :species
  end
end
