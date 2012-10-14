class SearchController < ApplicationController
  helper_method :query, :results

  def search
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
