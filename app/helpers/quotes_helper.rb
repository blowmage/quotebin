module QuotesHelper
  def show_tag_list(quote)
    quote.tag_list.map do |tag|
      link_to tag, tag_path(tag)
    end.join(', ').html_safe
  end
end
