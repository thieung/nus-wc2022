class PredictChampion < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  scope :order_by_created_date_desc, -> {order("created_at DESC")}
  scope :has_team, -> { where.not(team_id: nil) }
  scope :same_chosen, -> (current_user_id, team_id) {where.not(user_id: current_user_id).where(team_id: team_id)}
  scope :order_asc, -> {order("created_at ASC")}
end