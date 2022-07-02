class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :href
      t.string :id_spotify
      t.integer :time
      t.integer :status, default: 0 
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
