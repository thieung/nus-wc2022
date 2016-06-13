class Game < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: :team1_id
  belongs_to :team2, class_name: "Team", foreign_key: :team2_id
  belongs_to :round
  belongs_to :group
  has_one :investment

  has_many :bets, dependent: :destroy

  scope :not_locked, -> { where(locked: false) }
  scope :locked, -> { where(locked: true) }
  scope :ordered, -> {order(:pos)}
  scope :all_matches, -> { where(pos: [1..51]) }
  scope :group_stage, -> { where(pos: [1..36]) }
  scope :round_of_16, -> { where(pos: [37..44]) }
  scope :quarter_final, -> { where(pos: [45..48]) }
  scope :semi_final, -> { where(pos: [49, 50]) }
  scope :final, -> { where(pos: 51) }

  after_save :update_money_for_winners, if: lambda { |game| game.score_id_changed? && game.score_id.present? }
  after_save :update_match_information, if: lambda { |game| game.team1_id.present? && game.team2_id.present? && game.team1_id_changed? && game.team2_id_changed? }
  after_save :update_champion_team, if: lambda { |game| game.pos == 51 && game.winner.present?}

  def previous
    Game.find_by(pos: pos-1)
  end

  def next
    Game.find_by(pos: pos+1)
  end

  def can_bet?
    team1_id && team2_id
  end

  def has_score?
    score_id.present?
  end

  def deadline
    play_at - 30.minutes
  end

  def available_to_bet
    DateTime.now < deadline && !locked
  end

  def final_match?
    pos == 51
  end

  def first_match?
    pos == 1
  end

  def list_winners
    winners_ids = bets.select{|b| b.score_ids.map(&:to_i).include?(score_id)}.map(&:user_id).uniq
    winners = User.includes(:bets).where("users.id"=>winners_ids)
    winners
  end

  private

  def update_money_for_winners
    winners_ids = bets.select{|b| b.score_ids.map(&:to_i).include?(score_id)}.map(&:user_id).uniq
    total_money_for_final = final_match? ? Investment.sum(:remaining) : 0
    money_from_previous_match = if first_match?
      0
    else
      Investment.find_by(game_id: previous.id).try(:remaining) || 0
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

  def update_match_information
    collection = case pos
    when 44
      Game.round_of_16
    when 48
      Game.quarter_final
    when 50
      Game.semi_final
    when 51
      Game.final
    end
    if collection
      winner_team_ids = collection.map{|g| [g.team1_id, g.team2_id]}.flatten.uniq
      Team.where.not(id: winner_team_ids).update_all(eliminated: true) if winner_team_ids
    end
  end

  def update_champion_team
    team = Team.find_by(id: winner)
    team.update_attributes(is_champion: true) if team
  end
end