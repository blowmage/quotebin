class SearchController < ApplicationController
  helper_method :query, :results

  def search
    if results.count == 1
      quote = results.first
      redirect_to account_quote_path(quote.owner.username, quote.id)
    end
  end

  def autocomplete
    terms = Quote.search(params[:term]).select("substring(quotation from 0 for 80) AS term").limit(10).map(&:term)
    render json: terms
  end

  protected

  def query
    params[:q]
  end

  def results
    @results ||= Quote.search(query)
  end
end
