class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  helper :application

  def send_password_to_staff user, password
    @user = user
    @password = password
    @url = login_url
    mail(to: @user.email, subject: "[NUS Event - Euro 2016] Thông tin tài khoản")
  end

  def notice_bet_result_to_staffs recipient, bet_info
    @user = bet_info.user
    @score_content = Score.where(id: bet_info.score_ids.map(&:to_i)).map(&:name).join(', ')
    @game = bet_info.game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(from: @user.email, to: recipient, subject: "[NUS Event - Euro 2016] Dự đoán tỉ số trận #{@match_content}")
  end

  def notice_bet_result_updated_to_staffs recipient, bet_info
    @user = bet_info.user
    @score_content = Score.where(id: bet_info.score_ids.map(&:to_i)).map(&:name).join(', ')
    @game = bet_info.game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(from: @user.email, to: recipient, subject: "[NUS Event - Euro 2016] [Update] Dự đoán tỉ số trận #{@match_content}")
  end

  def notice_match_result_to_staffs recipient, game
    @game = game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    @winners = game.list_winners
    mail(to: recipient, subject: "[NUS Event - Euro 2016] Kết quả trận #{@match_content}")
  end

  def notice_predict_champion_result_to_staffs recipient, predict_champion
    @user = predict_champion.user
    @team = predict_champion.team
    @fee = predict_champion.money
    mail(from: @user.email, to: recipient, subject: "[NUS Event - Euro 2016] Dự đoán đội vô địch lần #{@user.total_teams_to_predict_champion}")
  end

  def notice_all_bets_info_to_staffs recipient, game
    @game = game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(to: recipient, subject: "[NUS Event - Euro 2016] Danh sách nhà đầu tư dự đoán tỉ số trận #{@match_content}")
  end

  def send_test
    mail(to: 'vanthieuuit@gmail.com', subject: "Test Schedule")
  end
end
