require "enumerize"
require "sequenced"

module Pokeviewer
  class Engine < ::Rails::Engine
    isolate_namespace Pokeviewer
  end
end
