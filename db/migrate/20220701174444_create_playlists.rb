class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :image_url
      t.boolean :public
      t.string :owner
      t.string :href
      t.string :uri
      t.string :path
      t.string :id_spotify
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
