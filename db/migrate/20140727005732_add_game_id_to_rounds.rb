class AddGameIdToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :game_id, :integer
    add_index :rounds, :game_id
  end
end
