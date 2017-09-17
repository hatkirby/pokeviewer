class CreatePokeviewerRevisionMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :pokeviewer_revision_moves do |t|
      t.references :revision, null: false
      t.references :move, null: false
      t.integer :number, null: false
      t.integer :pp_bonuses, null: false, default: 0

      t.timestamps
    end

    add_index :pokeviewer_revision_moves, [:revision_id, :number], unique: true

    add_foreign_key :pokeviewer_revision_moves, :pokeviewer_revisions,
      column: :revision_id

    add_foreign_key :pokeviewer_revision_moves, :pokeviewer_moves,
      column: :move_id
  end
end
