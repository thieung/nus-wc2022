class AddReasonToGames < ActiveRecord::Migration
  def change
    add_column :games, :reason, :string
  end
end
