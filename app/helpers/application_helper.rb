module ApplicationHelper
  def edit_field(builder, field, label, placeholder='')
    html = '<div class="form-group">'
    html += builder.label field, label
    html += builder.text_field field, class: "form-control", placeholder: placeholder
    if builder.object.errors.full_messages_for(field).any?
      builder.object.errors.full_messages_for(field).each do |message|
        html += '<p class="text-danger"><small>' + message + '</small></p>'
      end
    end
    html += '</div>'
    raw html
  end

  def panel_heading(title, title_link_html)
    title_class = !title_link_html.blank? ? 'pull-left' : ''
    html = '<div class="panel-heading"><div class="' + title_class + '">' + title + '</div>'
    html += '<div class="text-right">' + title_link_html + '</div>' if title_link_html
    html += '</div>'
    raw html
  end

  def panel_with_table(id, title, title_link_html, text, &block)
    table = capture(&block)
    html = '<div class="panel panel-default" id="' + id + '">'
    html += panel_heading title, title_link_html
    html += '<div class="panel-body"><p>' + text + '</p></div>' if text
    html += table if table
    html += '</div>'
    raw html
  end

  def panel_with_form_for(object, id, title, &block)
    html = '<div class="panel panel-default" id="' + id + '">'
    html += panel_heading title, ''
    html += '<div class="panel-body">'
    html += form_for(object) do |f|
      capture(f, &block)
    end
    html += '</div>'
    html += '</div>'
    raw html
  end
end
