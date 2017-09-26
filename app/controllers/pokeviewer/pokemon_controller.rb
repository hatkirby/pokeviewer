require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class PokemonController < ApplicationController
    def index
      @trainers = Trainer.all
      @unaccounted = Pokemon.where(trainer: nil)
    end

    def show
      @pokemon = Pokemon.find_by_uuid! params[:id]
    end
  end
end
