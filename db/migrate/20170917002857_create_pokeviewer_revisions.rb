class CreatePokeviewerRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :pokeviewer_revisions do |t|
      t.references :pokemon, null: false
      t.integer :sequential_id, null: false
      t.string :nickname, null: false
      t.integer :experience, null: false
      t.integer :level, null: false
      t.integer :hp, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :special_attack, null: false
      t.integer :special_defense, null: false
      t.integer :speed, null: false
      t.integer :coolness, null: false
      t.integer :beauty, null: false
      t.integer :cuteness, null: false
      t.integer :smartness, null: false
      t.integer :toughness, null: false
      t.integer :sheen, null: false
      t.integer :hold_item, null: true

      t.timestamps
    end

    add_index :pokeviewer_revisions, [:pokemon_id, :sequential_id], unique: true

    add_foreign_key :pokeviewer_revisions, :pokewalker_pokemon,
      column: :pokemon_id
  end
end
