module ApplicationHelper
  class ApplicationFromBuilder < ActionView::Helpers::FormBuilder
    def text_field(field, label, placeholder='')
      html = '<div class="form-group">'
      html += self.label field, label
      html += super(field, class: "form-control", placeholder: placeholder)
      html += error_text(field)
      html += '</div>'
      html.html_safe
    end

    def error_text(field)
      html =''
      if self.object.errors.full_messages_for(field).any?
        self.object.errors.full_messages_for(field).each do |message|
          html += '<p class="text-danger"><small>' + message + '</small></p>'
        end
      end
      html.html_safe
    end

    def search_select(method, objects, objects_method)
      object_name = model_name_from_record_or_class(@object).param_key
      fk_method = @object.send(method).foreign_key
      id = "#{object_name}_#{method}"

      # <li class="dropdown" id="current_project" data-child-maxwidth="true">
      @template.content_tag :div, class: "dropdown search-select", id: "#{object_name}_#{method}" do

        html = @template.content_tag :div, data: {'same-width' => "dropdown-menu-#{id}", :toggle => "dropdown"} do
          search_field(object_name, fk_method)
        end

        # filter objects from already added objects
        ids = @object.send(fk_method)
        filtered_objects = objects.select { |obj| !ids.include?(obj.id()) }

        html += search_dropdown(filtered_objects, objects_method, "dropdown-menu-#{id}")
      end.html_safe
    end

    private

    def search_field(object_name, fk_method)
      html = @template.hidden_field(object_name, fk_method)
      html += @template.text_field_tag(:search_val, nil, class: '')
      html += @template.content_tag :span, '', class: 'caret'
      html.html_safe
    end

    def search_dropdown(objects, method, id)

      @template.content_tag :ul, class: 'dropdown-menu', id: id do
        objects.map do |obj|
          text = @template.content_tag :a, obj.send(method), href: '#'
          @template.content_tag :li, text, data: {id: obj.id().to_s}
        end.join('').html_safe
      end
    end
  end


  def panel_heading(title, title_link_html)
    title_class = !title_link_html.blank? ? 'pull-left' : ''
    html = '<div class="panel-heading"><div class="' + title_class + '">' + title + '</div>'
    html += '<div class="text-right">' + title_link_html + '</div>' if title_link_html
    html += '</div>'
    raw html
  end

  def panel_with_table(id, title, title_link_html, text, &block)
    content = capture(&block)
    html = '<div class="panel panel-default" id="' + id + '">'
    html += panel_heading title, title_link_html
    html += '<div class="panel-body"><p>' + text + '</p></div>' if text
    html += content if content
    html += '</div>'
    raw html
  end

  def panel(id, title, title_link_html, &block)
    content = capture(&block)
    html = '<div class="panel panel-default" id="' + id + '">'
    html += panel_heading title, title_link_html
    html += '<div class="panel-body">'
    html += content if content
    html += '</div></div>'
    raw html
  end

  # Renders panel with form for object
  # @param [Mongoid::Document] object
  # @param [String] id attribute for panel
  # @param [String] title for panel
  # @param [Hash] options for form_for
  # @yield
  def panel_with_form_for(object, id, title, options={}, &block)
    options[:builder] = ApplicationFromBuilder
    html = '<div class="panel panel-default" id="' + id + '">'
    html += panel_heading title, ''
    html += '<div class="panel-body">'
    html += form_for(object, options) do |f|
      capture(f, &block)
    end
    html += '</div>'
    html += '</div>'
    raw html
  end

  def title_content
    title = content_for :title
    title = title.blank? ? 'Palladium' : "Palladium::#{title}"
    title
  end
end
