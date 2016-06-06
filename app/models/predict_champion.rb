class PredictChampion < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  scope :order_by_created_date, -> {order("created_at DESC")}
  scope :has_team, -> { where.not(team_id: nil) }
end