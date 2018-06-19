class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  helper :application

  def send_password_to_staff user, password
    @user = user
    @password = password
    @url = login_url
    mail(to: @user.email, subject: "[NUS Event - World Cup 2018] Thông tin tài khoản")
  end

  def notice_bet_result_to_staffs recipient, bet_info
    @user = bet_info.user
    @score_content = Score.where(id: bet_info.score_ids.map(&:to_i)).map(&:name).join(', ')
    @game = bet_info.game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(from: "#{@user.full_name.to_ascii} <no-reply@example.com>", to: recipient, subject: "[NUS Event - World Cup 2018] Dự đoán tỉ số trận #{@match_content}")
  end

  def notice_bet_result_updated_to_staffs recipient, bet_info
    @user = bet_info.user
    @score_content = Score.where(id: bet_info.score_ids.map(&:to_i)).map(&:name).join(', ')
    @game = bet_info.game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(from: "#{@user.full_name.to_ascii} <no-reply@example.com>", to: recipient, subject: "[NUS Event - World Cup 2018] [Update] Dự đoán tỉ số trận #{@match_content}")
  end

  def notice_match_result_to_staffs recipient, game
    @game = game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    @winners = game.list_winners
    mail(to: recipient, subject: "[NUS Event - World Cup 2018] Kết quả trận #{@match_content}")
  end

  def notice_predict_champion_result_to_staffs recipient, predict_champion
    @user = predict_champion.user
    @team = predict_champion.team
    @fee = predict_champion.money
    mail(from: "#{@user.full_name.to_ascii} <no-reply@example.com>", to: recipient, subject: "[NUS Event - World Cup 2018] Dự đoán đội vô địch lần #{@user.total_teams_to_predict_champion}")
  end

  def notice_all_bets_info_to_staffs recipient, game
    @game = game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(to: recipient, subject: "[NUS Event - World Cup 2018] Danh sách nhà đầu tư dự đoán tỉ số trận #{@match_content}")
  end

  def notice_champion_winner_result_to_staffs recipient
    money_for_champion = Settings.nus_money_for_champion.to_i + PredictChampion.sum(:money)
    winner_ids = PredictChampion.joins(:team).where("teams.is_champion" => true).map(&:user_id).uniq
    unless winner_ids.blank?
      @winner_list = User.where(id: winner_ids)
      @money_for_each_user = (money_for_champion.to_f/winner_ids.size).round
    end
    mail(to: recipient, subject: "[NUS Event - World Cup 2018] Kết quả dự đoán đội vô địch World Cup 2018")
  end

  def staffs_top_scores_report_after_first_round_group_stage recipient
    @statistics = []
    User.staffs.includes(:bets).find_each do |user|
      tmp = {
        user: user,
        total_scores: user.total_scores_betted,
        total_money_profits: user.total_profit_received
      }
      @statistics << tmp
    end
    @statistics.sort!{|a,b| b[:total_money_profits] <=> a[:total_money_profits]}
    mail(to: recipient, subject: "[NUS Event - World Cup 2018] Tổng hợp kết quả sau lượt trận đầu tiên vòng đấu bảng")
  end

  def send_test
    mail(to: 'vanthieuuit@gmail.com', subject: "Test Schedule")
  end
end
