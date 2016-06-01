class Game < ActiveRecord::Base
  belongs_to :team1, class_name: "Team", foreign_key: :team1_id
  belongs_to :team2, class_name: "Team", foreign_key: :team2_id
  belongs_to :round
  belongs_to :group
  has_many :user_scores

  scope :not_locked, -> { where(locked: false) }
  scope :ordered, -> {order(:pos)}
end