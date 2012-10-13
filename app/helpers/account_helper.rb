module AccountHelper
  def tag_list quote
    if quote.present? && quote.tags.present?
      quote.tag_list.map do |tag|
        link_to tag, tag_path(tag)
      end.join(', ').html_safe
    end
  end
end
