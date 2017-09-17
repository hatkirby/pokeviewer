class CreatePokeviewerTrainers < ActiveRecord::Migration[5.1]
  def change
    create_table :pokeviewer_trainers do |t|
      t.string :game, null: false
      t.string :name, null: false, limit: 191
      t.integer :number, null: false

      t.timestamps
    end

    add_index :pokeviewer_trainers, [:name, :number], unique: true
  end
end
