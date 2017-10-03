module Pokeviewer
  class Location < ApplicationRecord
    has_many :pokemon, dependent: :nullify

    validates :name, presence: true
  end
end
