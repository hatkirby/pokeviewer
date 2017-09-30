class CreatePokeviewerGiftRibbons < ActiveRecord::Migration[5.1]
  def change
    create_table :pokeviewer_gift_ribbons do |t|
      t.string :description, null: false

      t.timestamps
    end
  end
end
