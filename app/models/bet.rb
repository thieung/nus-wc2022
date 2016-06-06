class Bet < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  after_save :update_investment

  private

  def update_investment
    unit_price = game.round.money_rate
    money_users_bet = Bet.where(game_id: game_id).where.not(score_ids: []).sum(:total_money_bet)
    money_company_contribute = money_users_bet.to_i > 0 ? 3 * unit_price : 0
    Investment.find_by(game_id: game_id).update_attributes(total: money_users_bet + money_company_contribute)
  end
end
