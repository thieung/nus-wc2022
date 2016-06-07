class Game < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: :team1_id
  belongs_to :team2, class_name: "Team", foreign_key: :team2_id
  belongs_to :round
  belongs_to :group
  belongs_to :investment

  has_many :user_scores
  has_many :bets

  scope :not_locked, -> { where(locked: false) }
  scope :ordered, -> {order(:pos)}
  scope :all_matches, -> { where(pos: [1..51]) }
  scope :group_stage, -> { where(pos: [1..36]) }
  scope :round_of_16, -> { where(pos: [37..44]) }
  scope :quarter_final, -> { where(pos: [45..48]) }
  scope :semi_final, -> { where(pos: [49, 50]) }
  scope :final, -> { where(pos: 51) }

  after_save :update_money_for_winners, if: lambda { |game| game.score_id_changed? && game.score_id.present? && !game.locked }

  def can_bet?
    team1_id && team2_id
  end

  def has_score?
    score_id.present?
  end

  def deadline
    bet_date = if (0..16).to_a.include?(play_at.hour)
      play_at.to_date - 1.day
    else
      play_at.to_date
    end
    DateTime.parse "#{bet_date} 16:00:00 +7"
  end

  def available_to_bet
    DateTime.now < deadline
  end

  def final_match?
    pos == 51
  end

  def first_match?
    pos == 1
  end

  def previous_game
    Game.find_by(pos: pos-1)
  end

  private

  def update_money_for_winners
    winners_ids = bets.select{|b| b.score_ids.include?(score_id)}.maps(&:user_id).uniq
    total_money_for_final = final_match? ? Investment.sum(:remaining) : 0
    money_from_previous_match = if first_match?
      0
    else
      Investment.find_by(game_id: previous_game.id).try(:remaining) || 0
    end

    # Reset total money win
    bets.update_all(total_money_win: 0, locked: true)
    if winners_ids.size > 0
      # Update total money win
      money_for_each_people = ((investment.total + money_from_previous_match + total_money_for_final).to_f / winners_ids.size).round
      bets.where(user_id: winners_ids).update_all(total_money_win: money_for_each_people)
      investment.update_attributes(remaining: 0)
    else
      # No winner
      money_for_next_match = ((investment.total + money_from_previous_match + total_money_for_final).to_f / 2).round
      investment.update_attributes(remaining: money_for_next_match)
    end
  end
end