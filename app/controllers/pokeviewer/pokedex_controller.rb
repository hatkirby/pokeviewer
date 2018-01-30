require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class PokedexController < ApplicationController
    def index
      @species = Species.
        order(id: :asc).
        includes(:pokedex_entries).
        order("pokeviewer_pokedex_entries.trainer_id ASC")

      @trainers = Trainer.order(id: :asc)
    end
  end
end
