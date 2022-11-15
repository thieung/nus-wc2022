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
  scope :all_matches, -> { where(pos: [1..64]) }
  scope :group_stage, -> { where(pos: [1..48]) }
  scope :round_of_16, -> { where(pos: [49..56]) }
  scope :quarter_final, -> { where(pos: [57..60]) }
  scope :semi_final, -> { where(pos: [61, 62]) }
  scope :third_fourth, -> { where(pos: 63) }
  scope :final, -> { where(pos: 64) }

  after_save :update_money_for_winners, if: lambda { |game| game.score_id_changed? && game.score_id.present? }
  after_save :update_match_information, if: lambda { |game| game.team1_id.present? && game.team2_id.present? && game.team1_id_changed? && game.team2_id_changed? }
  after_save :update_champion_team, if: lambda { |game| game.pos == 64 && game.winner.present?}
  after_save :update_eliminated_team, if: lambda { |game| !game.third_fourth_match? && Game.finish_group_stage? && game.winner.present? }

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
    DateTime.current < deadline && !locked
  end

  def final_match?
    pos == 64
  end

  def third_fourth_match?
    pos == 63
  end

  def first_match?
    pos == 1
  end

  def list_winners
    winners_ids = bets.select{|b| b.score_ids.map(&:to_i).include?(score_id)}.map(&:user_id).uniq
    winners = User.includes(:bets).where("users.id"=>winners_ids)
    winners
  end

  def self.send_report_to_staffs
    current_time = DateTime.current
    available_games = Game.not_locked.select{|g| !g.is_reported && g.deadline < current_time && current_time < g.play_at}
    return if available_games.blank?

    available_games.each do |ga|
      Mailer.process_notice_all_bets_info_to_staffs(ga) unless Settings.is_turn_off_mail
      ga.update_attributes(is_reported: true)
    end
  end

  def self.finish_group_stage?
    self.group_stage.not_locked.size == 0
  end

  def self.finish_round_of_16?
    self.round_of_16.not_locked.size == 0
  end

  def self.finish_quarter_final?
    self.quarter_final.not_locked.size == 0
  end

  def self.finish_tournament?
    self.not_locked.size == 0
  end

  def is_knockout?
    pos >= 49
  end

  def is_draw?
    score1 == score2
  end

  def can_show_match_stats?
    return true if Settings.is_demo
    DateTime.current >= deadline
  end

  def self.started?
    self.locked.size > 0
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
    money_from_boss = Settings.boss_contribute&.find { |item| item['game_id'] == id }&.send(:[], 'money') || 0
    money_from_sponsor = Settings.sponsor_contribute&.find_all { |item| item['game_id'] == id }&.map(&:money).sum || 0

    # Reset total money win
    bets.update_all(total_money_win: 0, locked: true)
    if winners_ids.size > 0
      # Update total money win
      money_for_each_people = ((investment.total + money_from_previous_match + money_from_boss + money_from_sponsor + total_money_for_final).to_f / winners_ids.size).round
      bets.where(user_id: winners_ids).update_all(total_money_win: money_for_each_people)
      investment.update_attributes(remaining: 0)
    else
      # No winner
      money_for_next_match = ((investment.total + money_from_previous_match + money_from_boss + money_from_sponsor + total_money_for_final).to_f / 2).round
      unless final_match?
        investment.update_attributes(remaining: money_for_next_match)
      end
    end
  end

  def update_match_information
    collection = case pos
    when 56
      Game.round_of_16
    when 60
      Game.quarter_final
    when 62
      Game.semi_final
    when 63
      Game.third_fourth
    when 64
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
    # Send champion winner result email to all staffs
    Mailer.process_notice_champion_winner_result_to_staffs unless Settings.is_turn_off_mail
  end

  def update_eliminated_team
    if team1_id == winner
      Team.find_by(id: team2_id).update_attributes(eliminated: true)
    elsif team2_id == winner
      Team.find_by(id: team1_id).update_attributes(eliminated: true)
    end
  end
end
