module Pokeviewer
  class Species < ApplicationRecord
    has_many :pokemon, dependent: :restrict_with_exception

    validates :name, presence: true, uniqueness: true
  end
end
