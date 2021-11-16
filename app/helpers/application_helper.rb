module ApplicationHelper
  BOOTSTRAP_ALERT_CLASS = {
    "error" => "danger",
    "warning" => "warning",
    "notice" => "success",
    "alert" => "warning"
  }
  
  def display_flash
    return if flash.empty?
    flash.map do |key, value|
      content_tag :div, value, class: "alert alert-#{BOOTSTRAP_ALERT_CLASS[key] || "info"}" unless key == 'timedout'
    end.join("").html_safe
  end

  def errors_for(object)
    if object.errors.any?
      content_tag(:div, class: "card border-danger") do
        concat(content_tag(:div, class: "card-header bg-danger text-white") do
        	'Fix The Following Errors'
        end)
        concat(content_tag(:div, class: "card-body") do
            concat(content_tag(:ul, class: 'mb-0') do
                object.errors.full_messages.each do |msg|
                    concat content_tag(:li, msg)
                end
            end)
        end)
      end
    end
  end
end
