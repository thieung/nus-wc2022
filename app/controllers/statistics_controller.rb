class StatisticsController < ApplicationController
  def index
    @statistics = []
    User.staffs.includes(:bets).find_each do |user|
      tmp = {
        user: user,
        total_matches: user.bets.has_score.pluck(:game_id).uniq.size,
        total_scores: user.total_scores_betted,
        total_money_bet: user.total_money_bet,
        total_money_win: user.total_money_win,
        total_money_predict_champion: user.total_money_predict_champion,
        money_predict_champion_win: user.money_predict_champion_win,
        total_money_profits: user.total_profit_received
      }
      @statistics << tmp
    end
    @statistics.sort!{|a,b| b[:total_money_profits] <=> a[:total_money_profits]}
  end

  def records

  end
end
