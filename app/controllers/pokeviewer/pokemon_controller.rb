require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class PokemonController < ApplicationController
    def index
      @trainers = Trainer.all
    end

    def show
      @pokemon = Pokemon.find_by_uuid params[:id]
    end
  end
end
