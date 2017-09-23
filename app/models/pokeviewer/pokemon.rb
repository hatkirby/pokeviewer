module Pokeviewer
  class Pokemon < ApplicationRecord
    extend Enumerize

    belongs_to :species
    belongs_to :trainer, optional: true
    has_many :revisions, -> { order "sequential_id ASC" }, dependent: :destroy

    validate :uuid_is_constant, on: :update
    before_create :set_uuid

    validates :ot_name, presence: true

    validates :ot_number, presence: true,
      numericality: { greater_than_or_equal_to: 0, only_integer: true }

    validates :met_level, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :met_type, presence: true
    enumerize :met_type, in: [:normal, :hatched, :npc_trade, :fateful_encounter]

    validates :gender, presence: true
    enumerize :gender, in: [:genderless, :female, :male]

    validates :nature, presence: true
    enumerize :nature, in: [:hardy, :lonely, :brave, :adamant, :naughty, :bold,
      :docile, :relaxed, :impish, :lax, :timid, :hasty, :serious, :jolly,
      :naive, :modest, :mild, :quiet, :bashful, :rash, :calm, :gentle, :sassy,
      :careful, :quirky]

    enumerize :unown_letter, in: [:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k,
      :l, :m, :n, :o, :p, :q, :r, :s, :t, :u, :v, :w, :x, :y, :z,
      :question_mark, :exclamation_mark]

    def to_param
      uuid
    end

    private

      def set_uuid
        self.uuid = SecureRandom.uuid
      end

      def uuid_is_constant
        errors.add(:uuid, "can't be changed") if self.uuid_changed?
      end
  end
end
