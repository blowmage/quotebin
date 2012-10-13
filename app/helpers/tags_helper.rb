module TagsHelper
  def show_tags(list)
    list.map do |tag|
      link_to tag, tag_path(tag)
    end.join(', ').html_safe
  end
end
