module Pokeviewer
  class Revision < ApplicationRecord
    belongs_to :pokemon
    acts_as_sequenced scope: :pokemon_id

    validates :nickname, presence: true

    validates :experience, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :level, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :hp, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :attack, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :defense, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :special_attack, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :special_defense, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :speed, presence: true,
      numericality: { greater_than_or_equal_to: 1, only_integer: true }

    validates :coolness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :beauty, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :cuteness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :smartness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :toughness, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    validates :sheen, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 10,
        only_integer: true }

    belongs_to :move_1, class_name: "Move"
    belongs_to :move_2, class_name: "Move", optional: true
    belongs_to :move_3, class_name: "Move", optional: true
    belongs_to :move_4, class_name: "Move", optional: true

    validates :move_1_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :move_2_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :move_3_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}

    validates :move_4_pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}
  end
end
