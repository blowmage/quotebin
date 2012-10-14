module ApplicationHelper
  def quote_tile quote
    render partial: "shared/quote_tile", locals: { quote: quote }
  end

  def quote_button_bar quote
    render partial: "shared/quote_button_bar", locals: { quote: quote }
  end

  def tweet_quote_url quote
    qs = { text: truncate(quote.quotation, length: 100),
           url:  account_quote_url(quote.owner.username, quote.id),
           via:  "quotebin" }
    "https://twitter.com/intent/tweet?" + qs.to_query
  end
end
