module QuotesHelper
  def show_tag_list(quote)
    quote.tag_list.map do |tag|
      link_to tag, tag_path(tag)
    end.join(', ').html_safe
  end

  def markdown(text)
    options = {
      hard_wrap: true,
      filter_html: true,
      autolink: true,
      no_intraemphasis: true,
      fenced_code: true,
      gh_blockcode: true
    }
    renderer = Redcarpet::Render::SmartyHTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer)
    markdown.render(text).html_safe
  end

end
