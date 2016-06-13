class AddIsReportedToGames < ActiveRecord::Migration
  def change
    add_column :games, :is_reported, :boolean, default: false
  end
end
