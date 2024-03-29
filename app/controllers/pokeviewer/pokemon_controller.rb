require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class PokemonController < ApplicationController
    before_action :load_pokemon, only: [:show, :embed]

    def index
      pokemon = Pokemon.order(Arel.sql("trainer_id IS NULL DESC")).
        order(trainer_id: :asc).
        order(box: :asc).
        order(slot: :asc).
        joins(:current).
        includes(:current).
        chunk do |p|
          if p.trainer_id.nil?
            -1
          else
            p.trainer_id
          end
        end

      @unaccounted = []

      begin
        if pokemon.peek.first == -1
          @unaccounted = pokemon.next.second
        end
      rescue StopIteration
        # There are no Pokémon, but that's fine.
      end

      @trainers = Trainer.order(id: :asc).all.map do |trainer|
        if trainer.id == pokemon.peek.first
          party = []

          boxes = (1..14).map do |i|
            {
              name: trainer.box_name(i),
              pokemon: [nil] * 30
            }
          end

          pokemon.next.second.chunk do |p|
            if p.box.nil?
              -1
            else
              p.box
            end
          end.each do |box, pokes|
            if box == -1
              party = pokes
            else
              boxes[box-1][:pokemon] = (0..29).map do |i|
                if not pokes.empty? and (pokes.first.slot == i)
                  pokes.shift
                else
                  nil
                end
              end
            end
          end

          [trainer, party, boxes]
        else
          nil
        end
      end.compact
    end

    def show
    end

    def show_revision
      @revision = Revision.
        where(
          sequential_id: params[:revision_id],
          pokeviewer_pokemon: { uuid: params[:id] }
        ).includes(
          :species, :item, :move_1, :move_2, :move_3, :move_4,
          pokemon: [:trainer, :location]
        ).first

      @pokemon = @revision.pokemon

      render :show
    end

    def embed
      render layout: false
    end

    protected
      def load_pokemon
        @pokemon = Pokemon.includes(
            current: [
              :species, :item, :move_1, :move_2, :move_3, :move_4,
              pokemon: [:trainer, :location]]
          ).find_by_uuid! params[:id]

        @revision = @pokemon.current
      end
  end
end
