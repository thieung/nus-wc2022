class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]

  attr_accessor :login

  has_many :bets
  has_many :predict_champions

  scope :order_by_username, -> { order(:username) }
  scope :staffs, -> { with_role(:staff) }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
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

  def has_betted_on_match? game_id
    bets.exists?(game_id: game_id)
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

  def total_teams_to_predict_champion
    predict_champions.has_team.size
  end

  def has_predict_champion_first_time?
    total_teams_to_predict_champion == 1
  end

  def last_predict_champion_team
    predict_champions.order_by_created_date.first
  end
end
