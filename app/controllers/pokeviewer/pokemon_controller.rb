require_dependency "pokeviewer/application_controller"

module Pokeviewer
  class PokemonController < ApplicationController
    def index
      pokemon = Pokemon.joins(:revisions).
        order("trainer_id IS NULL DESC").
        order(trainer_id: :asc).
        order(box: :asc).
        order(slot: :asc).
        order("pokeviewer_revisions.sequential_id DESC").
        group("pokeviewer_pokemon.uuid").
        select(:box, :slot, :uuid, :trainer_id, :species_id).
        select(:ot_gender, :ot_name, :unown_letter).
        select("pokeviewer_revisions.nickname AS nickname").
        chunk do |p|
          if p.trainer_id.nil?
            -1
          else
            p.trainer_id
          end
        end

      if pokemon.peek.first == -1
        @unaccounted = pokemon.next.second
      else
        @unaccounted = []
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
      @pokemon = Pokemon.includes(
          :trainer, :species, :location,
          revisions: [:item, :move_1, :move_2, :move_3, :move_4]
        ).find_by_uuid! params[:id]
    end
  end
end
