require 'victor'

module Pokeviewer
  module PokemonHelper

    def condition_diagram(revision)
      svg = Victor::SVG.new width: 420, height: 430

      center_x = 200
      center_y = 200
      radius = 160

      angle = -Math::PI / 2.0
      incr = (2 * Math::PI) / 5

      data = [
        [:cool, revision.coolness],
        [:beauty, revision.beauty],
        [:cute, revision.cuteness],
        [:smart, revision.smartness],
        [:tough, revision.toughness]
      ]

      outline = data.map do |c|
        x_offset = radius * Math.cos(angle)
        y_offset = radius * Math.sin(angle)

        svg.circle(
          cx: (center_x + x_offset),
          cy: (center_y + y_offset),
          r: 53,
          class: "pkcv-#{c[0]}-circle")

        if c[0] == :cool
          text_y = center_y + (radius + 20) * Math.sin(angle)
        else
          text_y = center_y + (radius + 60) * Math.sin(angle)
        end

        svg.text(c[0].upcase,
          x: (center_x + (radius + 60) * Math.cos(angle)),
          y: text_y,
          class: "pkcv-label-outline")

        svg.text(c[0].upcase,
          x: (center_x + (radius + 60) * Math.cos(angle)),
          y: text_y,
          class: "pkcv-label")

        angle += incr

        [center_x + x_offset, center_y + y_offset]
      end

      svg.polygon(
        points: outline.map { |point| point * "," } * " ",
        class: "pkcv-outline")

      points = data.map do |c|
        svg.line(
          x1: center_x,
          y1: center_y,
          x2: center_x + radius * Math.cos(angle),
          y2: center_y + radius * Math.sin(angle),
          class: "pkcv-line")

        datapoint = c[1]
        datapoint = 0.01 if datapoint < 1
        datapoint /= 10.0
        datapoint **= (1.0/3.0)

        x_offset = (radius - 3) * Math.cos(angle) * datapoint
        y_offset = (radius - 3) * Math.sin(angle) * datapoint

        angle += incr

        [center_x + x_offset, center_y + y_offset]
      end

      svg.polygon(
        points: points.map { |point| point * "," } * " ",
        class: "pkcv-data")

      tag.svg(svg.to_s.html_safe,
        viewBox: "-80 -30 570 430",
        width: "100%",
        class: "pokemon-condition")
    end

    def image_for_type(type)
      image_tag "pokeviewer/types/#{type}.gif"
    end

    def move_details(revision, index)
      move = revision.send "move_#{index}".intern

      if move
        move_name = move.name
        move_type = image_for_type move.move_type
        move_pp = revision.send "move_#{index}_pp".intern
        move_pp = "#{move_pp}/#{move_pp}"
      else
        move_name = "-"
        move_type = ""
        move_pp = "--/--"
      end

      tag.tr(
        tag.th(move_type) +
        tag.td(move_name)) +
      tag.tr(
        tag.th("") +
        tag.td(
          tag.div(
            tag.span(
              "PP",
              class: 'pp-label') +
            tag.span(
              move_pp,
              class: 'pp-value') +
            tag.div(
              "",
              class: 'clear'),
            class: 'tb-only')))
    end

    def display_met(pokemon)
      met_type = pokemon.met_type

      if met_type == :normal or met_type == :hatched
        result = "".html_safe

        if met_type == :normal
          if pokemon.outsider?
            result << "Apparently met"
          else
            result << "Met"
          end
        else
          if pokemon.outsider?
            result << "Apparently hatched"
          else
            result << "Hatched"
          end
        end

        result << " in "

        pokemon.location.name.split(" ").each_with_index do |w, i|
          result << "&nbsp;".html_safe if i > 0
          result << w
        end

        result << " at Lv.&nbsp;".html_safe

        if met_type == :hatched
          result << "5"
        else
          result << pokemon.met_level.to_s
        end

        result << "."

        result
      elsif met_type == :npc_trade
        "Met in a trade."
      elsif met_type == :fateful_encounter
        "Obtained in a fateful encounter at Lv.&nbsp;".html_safe +
          pokemon.met_level.to_s
      elsif met_type == :orre
        "Met in a trade."
      end
    end

  end
end
