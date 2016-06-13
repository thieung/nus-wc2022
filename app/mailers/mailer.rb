class Mailer
  def self.process_notice_bet_result_to_staffs bet_info
    Settings.group_mails.each do |recipient|
      UserMailer.delay.notice_bet_result_to_staffs recipient, bet_info
    end
  end

  def self.process_notice_bet_result_updated_to_staffs bet_info
    Settings.group_mails.each do |recipient|
      UserMailer.delay.notice_bet_result_updated_to_staffs recipient, bet_info
    end
  end

  def self.process_notice_match_result_to_staffs game
    Settings.group_mails.each do |recipient|
      UserMailer.notice_match_result_to_staffs(recipient, game).deliver
    end
  end

  def self.process_notice_predict_champion_result_to_staffs predict_champion
    Settings.group_mails.each do |recipient|
      UserMailer.delay.notice_predict_champion_result_to_staffs recipient, predict_champion
    end
  end

  def self.process_notice_all_bets_info_to_staffs game
    Settings.group_mails.each do |recipient|
      UserMailer.notice_all_bets_info_to_staffs(recipient, game).deliver
    end
  end
end