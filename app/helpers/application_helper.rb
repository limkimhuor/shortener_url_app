module ApplicationHelper
  def error_message resource, *attr
    message = resource.errors.messages.values_at(*attr).flatten[0]
    return if message.blank?
    content_tag :div, message, class: "text-error"
  end
end
