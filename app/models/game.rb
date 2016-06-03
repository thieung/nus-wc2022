class Game < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: :team1_id
  belongs_to :team2, class_name: "Team", foreign_key: :team2_id
  belongs_to :round
  belongs_to :group
  has_many :user_scores

  scope :not_locked, -> { where(locked: false) }
  scope :ordered, -> {order(:pos)}
  scope :all_matches, -> { where(pos: [1..51]) }
  scope :group_stage, -> { where(pos: [1..36]) }
  scope :round_of_16, -> { where(pos: [37..44]) }
  scope :quarter_final, -> { where(pos: [45..48]) }
  scope :semi_final, -> { where(pos: [49, 50]) }
  scope :final, -> { where(pos: 51) }

  def can_bet?
    team1_id && team2_id
  end

  def deadline
    bet_date = if (0..16).to_a.include?(play_at.hour)
      play_at.to_date - 1.day
    else
      play_at.to_date
    end
    DateTime.parse "#{bet_date} 16:00:00 +7"
  end

  def final_match?
    pos == 51
  end
end