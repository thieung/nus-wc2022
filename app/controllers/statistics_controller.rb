class StatisticsController < ApplicationController
  def index
    @statistics = []
    all_budgets = Bet.all.group_by(&:user_id)
    users = User.where(id: all_budgets.keys).index_by(&:id)
    all_budgets.each do |user_id, budgets|
      total_money_bet = budgets.sum(&:total_money_bet)
      total_money_win = budgets.sum(&:total_money_win)
      total_money_profits = total_money_win - total_money_bet
      user_scores = UserScore.where(user_id: user_id)
      @statistics << {user: users[user_id], total_matches: user_scores.group_by(&:game_id).size, total_scores: user_scores.size, total_money_bet: total_money_bet, total_money_win: total_money_win, total_money_profits: total_money_profits}
    end
    @statistics = @statistics.sort{|a,b| b[:total_money_profits] <=> a[:total_money_profits]}
  end
end
