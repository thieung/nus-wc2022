class AddIsReportedToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :is_reported, :boolean, default: false
  end
end
