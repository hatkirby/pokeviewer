class CreatePokeviewerMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :pokeviewer_moves do |t|
      t.string :name, null: false, limit: 191
      t.integer :pp, null: false

      t.timestamps
    end

    add_index :pokeviewer_moves, :name, unique: true
  end
end
