module Pokeviewer
  class Species < ApplicationRecord
    extend Enumerize

    has_many :revisions, dependent: :restrict_with_exception

    validates :name, presence: true, uniqueness: true

    validates :type_1, presence: true

    enumerize :type_1, in: Move::TYPES
    enumerize :type_2, in: Move::TYPES

    belongs_to :ability_1, class_name: "Ability"
    belongs_to :ability_2, class_name: "Ability", optional: true
  end
end
