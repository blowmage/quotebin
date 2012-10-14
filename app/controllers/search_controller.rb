class SearchController < ApplicationController
  include ActionView::Helpers::TextHelper # for truncate
  helper_method :query, :results

  def search
    if results.count == 1
      quote = results.first
      redirect_to account_quote_path(quote.owner.username, quote.id)
    end
  end

  def autocomplete
    payload = []
    if results.total_count > 0
      payload << { value: query, label: "There are #{results.total_count} results for \"#{query}\"".html_safe, url: search_path(q: query) }
      results.limit(8).each do |q|
        payload << { value: query, label: "<em>\"#{truncate(q.quotation, length: 60)}\"</em> by <strong>#{q.author}</strong>".html_safe, url: account_quote_path(q.owner.username, q.id) }
      end
      payload << { value: query, label: "<strong>Search for <em>\"#{query}\"</em>".html_safe, url: search_path(q: query) }
      payload << { value: query, label: "<strong>Create a quote for <em>\"#{query}\"</em>".html_safe, url: new_quote_path }
    end

    render json: payload
  end

  protected

  def query
    params[:q] || params[:term]
  end

  def results
    @results ||= Quote.search(query).page(params[:page]).per(20)
  end
end
