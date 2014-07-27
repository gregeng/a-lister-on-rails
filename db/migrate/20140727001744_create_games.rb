class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :starting_actor

      t.timestamps
    end
  end
end
