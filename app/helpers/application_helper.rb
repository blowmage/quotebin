module ApplicationHelper
  def quote_tile quote
    render partial: "shared/quote_tile", locals: { quote: quote }
  end
end
