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
      UserMailer.notice_match_result_to_staffs(recipient, game).deliver_now
    end
  end

  def self.process_notice_predict_champion_result_to_staffs predict_champion
    Settings.group_mails.each do |recipient|
      UserMailer.delay.notice_predict_champion_result_to_staffs recipient, predict_champion
    end
  end

  def self.process_notice_all_bets_info_to_staffs game
    Settings.group_mails.each do |recipient|
      UserMailer.notice_all_bets_info_to_staffs(recipient, game).deliver_now
    end
  end

  def self.process_notice_champion_winner_result_to_staffs
    Settings.group_mails.each do |recipient|
      UserMailer.notice_champion_winner_result_to_staffs(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_first_round_group_stage
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_first_round_group_stage(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_second_round_group_stage
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_second_round_group_stage(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_third_round_group_stage
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_third_round_group_stage(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_round_of_16
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_round_of_16(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_quarter_final
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_quarter_final(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_semi_final
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_semi_final(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_third_fourth
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_third_fourth(recipient).deliver_now
    end
  end

  def self.process_staffs_top_scores_report_after_final
    Settings.group_mails.each do |recipient|
      UserMailer.staffs_top_scores_report_after_final(recipient).deliver_now
    end
  end
end