class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  def send_password_to_staff user, password
    @user = user
    @password = password
    @url = login_url
    mail(to: @user.email, subject: "[NUS Event - Euro 2016] Thông tin tài khoản")
  end

  def notice_bet_result_to_staffs bet_info
    @user = bet_info.user
    @score_content = Score.where(id: bet_info.score_ids.map(&:to_i)).map(&:name).join(', ')
    @game = bet_info.game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(from: @user.email, to: Settings.staffs_mail_group, subject: "[NUS Event - Euro 2016] Dự đoán tỉ số trận #{@match_content}")
  end

  def notice_bet_result_updated_to_staffs bet_info
    @user = bet_info.user
    @score_content = Score.where(id: bet_info.score_ids.map(&:to_i)).map(&:name).join(', ')
    @game = bet_info.game
    @match_content = "#{@game.team1.title_vi} - #{@game.team2.title_vi}"
    mail(from: @user.email, to: Settings.staffs_mail_group, subject: "[NUS Event - Euro 2016] [Update] Dự đoán tỉ số trận #{@match_content}")
  end
end
