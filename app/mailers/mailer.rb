class Mailer
  def self.process_notice_bet_result_to_staffs bet_info
    Settings.group_mails_with_hr.each do |recipient|
      UserMailer.delay.notice_bet_result_to_staffs recipient, bet_info
    end
  end

  def self.process_notice_bet_result_updated_to_staffs bet_info
    Settings.group_mails_with_hr.each do |recipient|
      UserMailer.delay.notice_bet_result_updated_to_staffs recipient, bet_info
    end
  end

  def self.process_notice_match_result_to_staffs game
    Settings.group_mails.each do |recipient|
      UserMailer.delay.notice_match_result_to_staffs recipient, game
    end
  end
end