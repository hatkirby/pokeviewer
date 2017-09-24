class AddOtGenderToPokemon < ActiveRecord::Migration[5.1]
  def change
    add_column :pokeviewer_pokemon, :ot_gender, :string, null: false, default: ""
  end
end
