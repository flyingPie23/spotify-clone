class AddDurationToSongs < ActiveRecord::Migration[7.0]
  def change
    add_column :songs, :duration, :integer
  end
end
