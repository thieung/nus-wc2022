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

  def get_predict_status_text index, staff
    case index
    when 1
      if !Game.started? && DateTime.current <= DateTime.parse(Settings.predict_champion_deadline.first)
        'TBD'
      else
        'VIỆT NAM VÔ ĐỊCH'
      end
    when 2
      DateTime.current > DateTime.parse(Settings.predict_champion_deadline.second) && staff.predicted_team_eliminated?(index-1) ? 'KHÔNG DỰ ĐOÁN' : "N/A"
    else
      DateTime.current > DateTime.parse(Settings.predict_champion_deadline.third) && staff.predicted_team_eliminated?(index-1) ? 'KHÔNG DỰ ĐOÁN' : "N/A"
    end
  end
end
