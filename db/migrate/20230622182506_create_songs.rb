class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :cover

      t.timestamps
    end
  end
end
