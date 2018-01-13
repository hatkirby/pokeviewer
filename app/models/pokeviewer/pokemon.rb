module Pokeviewer
  class Pokemon < ApplicationRecord
    extend Enumerize
    extend ActiveModel::Naming

    has_many :revisions, -> { order "sequential_id ASC" }, dependent: :destroy
    has_one :current, -> { order "sequential_id DESC" }, class_name: "Revision"

    belongs_to :trainer, optional: true

    validates :box, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 14,
        only_integer: true },
      allow_nil: true

    validates :slot, presence: true,
      uniqueness: { scope: [:trainer_id, :box] },
      numericality: {
        greater_than_or_equal_to: 0,
        only_integer: true },
      unless: Proc.new { |a| a.trainer_id.nil? }

    validates :slot,
      numericality: { less_than: 30 },
      unless: Proc.new { |a| a.trainer_id.nil? or a.box.nil? }

    validates :slot,
      numericality: { less_than: 6 },
      unless: Proc.new { |a| a.trainer_id.nil? or not a.box.nil? }

    scope :party, -> { where(box: nil) }
    scope :box, ->(n) { where(box: n) }
    scope :unaccounted, -> { where(trainer_id: nil) }

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
    enumerize :met_type,
      in: [:normal, :hatched, :npc_trade, :fateful_encounter, :orre]

    belongs_to :location, optional: true
    validates :location, presence: true,
      if: Proc.new { |c| c.met_type == :normal or c.met_type == :hatched}

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

    validates :pokeball, presence: true
    enumerize :pokeball, in: [:master, :ultra, :great, :poke, :safari, :net,
      :dive, :nest, :repeat, :timer, :luxury, :premier]

    def to_param
      uuid
    end

    def outsider?
      (trainer.nil?) or (ot_name != trainer.name) or (ot_number != trainer.number)
    end

    def display_ot_number
      ot_number.to_s.rjust(5, '0')
    end

    def nature_benefits?(stat)
      if stat == :attack
        [:lonely, :brave, :adamant, :naughty].include? nature.intern
      elsif stat == :defense
        [:bold, :relaxed, :impish, :lax].include? nature.intern
      elsif stat == :speed
        [:timid, :hasty, :jolly, :naive].include? nature.intern
      elsif stat == :special_attack
        [:modest, :mild, :quiet, :rash].include? nature.intern
      elsif stat == :special_defense
        [:calm, :gentle, :sassy, :careful].include? nature.intern
      else
        false
      end
    end

    def nature_hinders?(stat)
      if stat == :attack
        [:bold, :timid, :modest, :calm].include? nature.intern
      elsif stat == :defense
        [:lonely, :hasty, :mild, :gentle].include? nature.intern
      elsif stat == :speed
        [:brave, :relaxed, :quiet, :sassy].include? nature.intern
      elsif stat == :special_attack
        [:adamant, :impish, :jolly, :careful].include? nature.intern
      elsif stat == :special_defense
        [:naughty, :lax, :naive, :rash].include? nature.intern
      else
        false
      end
    end

    def pokeball_icon_path
      "pokeviewer/items/#{Pokemon.pokeball.values.find_index(pokeball) + 1}.png"
    end

    def gift_ribbon_description(ribbon)
      if trainer.nil?
        ""
      else
        trainer.gift_ribbon_description(ribbon)
      end
    end

    def gender_symbol
      case gender.intern
      when :female
        "♀"
      when :male
        "♂"
      when :genderless
        ""
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
