module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert mbm" id="error_explanation">
      <header class="alert__header b">#{sentence}</header>
      <div class="alert__message">
        <ul>#{messages}</ul>
      </div>
    </div>
    HTML

    html.html_safe
  end
end
