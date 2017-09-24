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

    validates :ot_gender, presence: true
    enumerize :ot_gender, in: [:female, :male]

    validates :met_level, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true },
      if: Proc.new { |a| a.met_type == :normal }

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
      :question, :exclamation]
      
    validates :slot, presence: true,
      uniqueness: { scope: [:trainer_id, :box] },
      unless: Proc.new { |a| a.trainer.nil? }

    def to_param
      uuid
    end

    def icon_path
      "pokeviewer/icons/#{species_id}.png"
    end

    def sprite_path
      shininess = "normal"
      if shiny
        shininess = "shiny"
      end

      game = "ruby-sapphire"
      unless trainer.nil?
        if (trainer.firered? or trainer.leafgreen?) and (species_id <= 156 or species_id == 216 or species_id == 386)
          game = "firered-leafgreen"
        elsif trainer.emerald?
          game = "emerald"
        end
      end

      form = ""
      if species_id == 201
        # Handle Unown forms
        form = "-#{unown_letter}"
      elsif species_id == 386
        # Handle Deoxys forms
        if trainer.firered?
          form = "-attack"
        elsif trainer.leafgreen?
          form = "-defense"
        elsif trainer.emerald?
          form = "-speed"
        end
      end

      if game == "emerald"
        "pokeviewer/sprites/emerald/#{shininess}/#{species_id}#{form}.gif"
      else
        "pokeviewer/sprites/#{game}/#{shininess}/#{species_id}#{form}.png"
      end
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
