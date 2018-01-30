module Pokeviewer
  class Species < ApplicationRecord
    extend Enumerize

    has_many :revisions, dependent: :restrict_with_exception

    has_many :pokedex_entries, dependent: :destroy

    validates :name, presence: true, uniqueness: true

    validates :type_1, presence: true

    enumerize :type_1, in: Move::TYPES
    enumerize :type_2, in: Move::TYPES

    belongs_to :ability_1, class_name: "Ability"
    belongs_to :ability_2, class_name: "Ability", optional: true

    def current_revisions
      revisions.
        where("pokeviewer_pokemon.current_id = pokeviewer_revisions.id").
        includes(:pokemon).
        references(:pokemon)
    end
  end
end
