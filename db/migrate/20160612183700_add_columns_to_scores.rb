class AddColumnsToScores < ActiveRecord::Migration
  def change
    add_column :scores, :score1, :integer
    add_column :scores, :score2, :integer
    Score.find_each do |score|
      score.score1 = score.name.split('-')[0].to_i
      score.score2 = score.name.split('-')[1].to_i
      score.save!
    end
  end
end
