module Pokeviewer
  class GiftRibbon < ApplicationRecord
    validates :description, presence: true
  end
end
