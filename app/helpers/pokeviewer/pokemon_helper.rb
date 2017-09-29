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

      svg.polygon points: outline.map { |point| point * "," } * " ", class: "pkcv-outline"

      points = data.map do |c|
        datapoint = c[1]
        datapoint = 0.01 if datapoint < 1
        datapoint /= 10.0
        datapoint **= (1.0/3.0)

        x_offset = (radius - 3) * Math.cos(angle) * datapoint
        y_offset = (radius - 3) * Math.sin(angle) * datapoint

        angle += incr

        [center_x + x_offset, center_y + y_offset]
      end

      svg.polygon points: points.map { |point| point * "," } * " ", class: "pkcv-data"

      tag.svg(svg.to_s.html_safe,
        viewBox: "0 -30 410 430",
        width: 410,
        class: "pokemon-condition")
    end

  end
end
