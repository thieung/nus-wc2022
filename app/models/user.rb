class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]

  attr_accessor :login

  has_many :bets, dependent: :destroy
  has_many :predict_champions, dependent: :destroy
  has_many :members, foreign_key: :alliance_id, class_name: "UserAlliance"

  validates :nickname, length: { maximum: 40 }

  scope :order_by_username, -> { order(:username) }
  scope :staffs, -> { with_role(:staff) }
  scope :active, -> { where(is_active: true) }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  def display_name
    show_name = full_name || username || email
    unless nickname.blank?
      show_name = "#{show_name} (#{nickname})"
    end
    show_name
  end

  def active_for_authentication?
    super && self.is_active
  end

  def inactive_message
    "Tài khoản này đã bị khóa, vui lòng liên hệ với người quản lý."
  end

  def is_admin?
    self.has_role? :boss
  end

  def can_update_result_on_match? game_id
    pos = Game.find_by(id: game_id).try(:pos)
    return true if pos == 1
    return is_admin? && (Game.where(pos: (1..pos-1).to_a).not_locked.size == 0)
  end

  def has_betted_on_match? game_id
    bets.has_score.exists?(game_id: game_id)
  end

  def get_bet_info_on_match game_id
    bets.where(game_id: game_id).first
  end

  def score_ids_on_match game_id
    user_bet = get_bet_info_on_match game_id
    if user_bet
      user_bet.score_ids.map(&:to_i)
    end
  end

  def has_betted_enough_scores? game_id
    score_ids = score_ids_on_match game_id
    return false if score_ids.blank?
    score_ids.size == MAX_SCORE_CAN_BET
  end

  def remaining_scores_can_bet game_id
    user_bet = get_bet_info_on_match game_id
    return MAX_SCORE_CAN_BET if user_bet.blank?
    MAX_SCORE_CAN_BET - user_bet.score_ids.size
  end

  def total_teams_to_predict_champion
    predict_champions.has_team.size
  end

  def has_predict_champion_first_time?
    total_teams_to_predict_champion == 1
  end

  def last_predict_champion_team
    predict_champions.has_team.order_by_created_date.first
  end

  def champion_team_predicted
    last_predict_champion_team.try(:team)
  end

  def available_to_predict_champion?
    check = false
    case total_teams_to_predict_champion
    when 0
      check = DateTime.current < DateTime.parse(Settings.predict_champion_deadline.first)
    when 1
      check = champion_team_predicted.eliminated && DateTime.current < DateTime.parse(Settings.predict_champion_deadline.second)
    when 2
      check = champion_team_predicted.eliminated && DateTime.current < DateTime.parse(Settings.predict_champion_deadline.third)
    end
    check
  end

  ###### Money statistic

  def total_money_win_on_match game_id
    get_bet_info_on_match(game_id).try(:total_money_win) || 0
  end

  def total_money_bet
    bets.sum(:total_money_bet)
  end

  def total_money_win
    bets.sum(:total_money_win)
  end

  def total_money_predict_champion
    if DateTime.current < DateTime.parse(Settings.predict_champion_deadline.first)
      predict_champions.has_team.sum(:money)
    else
      predict_champions.sum(:money)
    end
  end

  def money_predict_champion_win
    money_predict_champion_win = 0
    if Game.not_locked.size == 0
      money_for_champion = Settings.nus_money_for_champion.to_i + PredictChampion.sum(:money)
      winner_ids = PredictChampion.joins(:team).where("teams.is_champion" => true).map(&:user_id).uniq
      unless winner_ids.blank?
        money_for_each_user = (money_for_champion.to_f/winner_ids.size).round
        if winner_ids.include?(self.id)
          money_predict_champion_win = money_for_each_user
        end
      end
    end
    money_predict_champion_win
  end

  def total_profit_received
    if Game.not_locked.size == 0
      # Finish euro
      (total_money_win + money_predict_champion_win) - (total_money_bet + total_money_predict_champion)
    else
      total_money_win - total_money_bet
    end
  end

  def total_win_matches
    bets.has_score.win.size
  end

  def total_lose_matches
    bets.has_score.lose.size
  end

  def total_lose_scores
    total_scores_betted - total_win_matches
  end

  def total_attended_matches
    bets.has_score.size
  end

  def total_scores_betted
    bets.has_score.pluck(:score_ids).flatten.size
  end

  def biggest_money_win_info
    bets.has_score.order_by_money_win.first
  end

  def self.list_order_by_numer_scores_betted
    result = []
    User.staffs.includes(:bets).find_each do |user|
      tmp = {
        user: user,
        total_scores: user.total_scores_betted,
        total_money_bet: user.total_money_bet
      }
      result << tmp
    end
    result.sort!{|a,b| b[:total_scores] <=> a[:total_scores]}
  end

  def self.list_order_by_win_rate
    result = {
      by_score: [],
      by_match: []
    }
    User.staffs.includes(:bets).find_each do |user|
      total_win_matches = user.total_win_matches
      total_attended_matches = user.total_attended_matches
      total_scores_betted = user.total_scores_betted

      tmp_by_match = {
        user: user,
        total_attended_matches: total_attended_matches,
        total_win_matches: total_win_matches,
        rate: total_win_matches > 0 ? (total_win_matches.to_f/total_attended_matches) : 0
      }
      result[:by_match] << tmp_by_match

      tmp_by_score = {
        user: user,
        total_scores_betted: total_scores_betted,
        total_scores_win: total_win_matches,
        rate: total_win_matches > 0 ? (total_win_matches.to_f/total_scores_betted) : 0
      }
      result[:by_score] << tmp_by_score
    end
    result[:by_score].sort!{|a,b| [b[:rate], b[:total_scores_win], b[:total_scores_betted]] <=> [a[:rate], a[:total_scores_win], a[:total_scores_betted]]}
    result[:by_match].sort!{|a,b| [b[:rate], b[:total_win_matches], b[:total_attended_matches]] <=> [a[:rate], a[:total_win_matches], a[:total_attended_matches]]}
    result
  end

  def self.list_order_by_lose_rate
    result = {
      by_score: [],
      by_match: []
    }
    User.staffs.includes(:bets).find_each do |user|
      total_lose_matches = user.total_lose_matches
      total_lose_scores = user.total_lose_scores
      total_attended_matches = user.total_attended_matches
      total_scores_betted = user.total_scores_betted

      tmp_by_match = {
        user: user,
        total_attended_matches: total_attended_matches,
        total_lose_matches: total_lose_matches,
        rate: total_lose_matches > 0 ? (total_lose_matches.to_f/total_attended_matches) : 0
      }
      result[:by_match] << tmp_by_match

      tmp_by_score = {
        user: user,
        total_scores_betted: total_scores_betted,
        total_scores_lose: total_lose_scores,
        rate: total_lose_scores > 0 ? (total_lose_scores.to_f/total_scores_betted) : 0
      }
      result[:by_score] << tmp_by_score
    end
    result[:by_score].sort!{|a,b| [b[:rate], b[:total_scores_lose], b[:total_scores_betted]] <=> [a[:rate], a[:total_scores_lose], a[:total_scores_betted]]}
    result[:by_match].sort!{|a,b| [b[:rate], b[:total_lose_matches], b[:total_attended_matches]] <=> [a[:rate], a[:total_lose_matches], a[:total_attended_matches]]}
    result
  end

  def self.list_order_by_money_win_in_a_match
    result = []
    User.staffs.joins(:bets).includes(bets: [game: [:team1, :team2, :round]]).uniq.find_each do |user|
      bet_info = user.biggest_money_win_info
      tmp = {
        user: user,
        game: bet_info.game,
        round: bet_info.game.round,
        team1: bet_info.game.team1,
        team2: bet_info.game.team2,
        total_money_win: bet_info.try(:total_money_win) || 0
      }
      result << tmp
    end
    result.sort!{|a,b| b[:total_money_win] <=> a[:total_money_win]}
  end

  def self.list_order_by_total_money_profits
    result = []
    User.staffs.includes(:bets).find_each do |user|
      tmp = {
        user: user,
        total_money_profits: user.total_profit_received
      }
      result << tmp
    end
    result.sort!{|a,b| b[:total_money_profits] <=> a[:total_money_profits]}
  end

  def self.top1
    User.list_order_by_total_money_profits.first[:user]
  end

  def self.top5
    User.list_order_by_total_money_profits.first(5)
  end

  def self.bottom1
    User.list_order_by_total_money_profits.last[:user]
  end

  def self.bottom5
    User.list_order_by_total_money_profits.last(5)
  end
end
