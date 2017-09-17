module Pokeviewer
  class RevisionMove < ApplicationRecord
    belongs_to :revision
    belongs_to :move

    validates :number, presence: true,
      numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 4,
        only_integer: true },
      uniqueness: { scope: :revision_id }

    validates :pp_bonuses, presence: true,
      numericality: {
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: 3,
        only_integer: true}
  end
end
