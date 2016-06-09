module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  def format_currency number, currency_text=true
    result = number_with_delimiter(number, delimiter: '.')
    result+=" VNĐ" if currency_text
    result
  end
end
