module UsersHelper
  def get_predict_label index
    case index
    when 1
      t('predict_champion.before_group_stage')
    when 2
      t('predict_champion.before_round_of_16')
    else
      t('predict_champion.before_quarter_final')
    end
  end

  def get_predict_status_text index
    case index
    when 1
      # Before group stage
      if !Game.started? && DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.first)
        'TBD'
      else
        'VIỆT NAM VÔ ĐỊCH'
      end
    when 2
      # Before round of 16
      finish_round_of_16? ? 'KHÔNG DỰ ĐOÁN' : "N/A"
    else
      # Before quarter final
      finish_quarter_final? ? 'KHÔNG DỰ ĐOÁN' : "N/A"
    end
  end
end
