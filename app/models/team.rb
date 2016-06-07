class Team < ActiveRecord::Base
  scope :join_euro, -> { where.not(title_vi: nil) }
  scope :not_eliminated, -> { where(eliminated: false) }
  scope :order_by_title_vi, -> { order(:title_vi) }

  def self.champion
    self.where(is_champion: true).first
  end
end