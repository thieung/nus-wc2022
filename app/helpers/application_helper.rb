module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  def format_currency number, currency_text=true
    result = number_with_delimiter(number, delimiter: '.')
    result+=" Points" if currency_text
    result
  end

  def format_percentage number
    number_to_percentage(number*100, precision: 2)
  end

  def get_predict_label_by_time
    if finish_round_of_16?
      t('predict_champion.before_quarter_final')
    elsif finish_group_stage?
      t('predict_champion.before_round_of_16')
    else
      t('predict_champion.before_group_stage')
    end
  end
end
