module ApplicationHelper
  class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
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

    def search_select(method, objects_name_method, url, options={})
      id = "#{object_name}_#{method}"
      fk_method = @object.reflect_on_association(method).foreign_key
      data = {
          'search-path' => url,
          'same-width' => "dropdown-menu-#{id}",
          'id' => "#{@object_name}_#{fk_method}",
          'name' => "#{@object_name}[#{fk_method}]"
      }
      data[:multiple] = true if options[:multiple]


      @template.content_tag :div,
                            class: "form-control dropdown search-select clearfix",
                            id: "#{object_name}_#{method}",
                            data: data do

        html = search_select_selected(@object.send(method), objects_name_method, fk_method, options)
        html += search_select_input_group(method)
        html += search_select_dropdown_menu(id)
        html
      end.html_safe
    end

    private

    def search_select_selected(items, name_method, fk_method, options={})
      @template.content_tag :div, class: "selected-items" do
        html = options[:multiple] ? hidden_field(fk_method, :multiple => true, :value => '') : hidden_field(fk_method, :value => '')
        Array.wrap(items).each do |item|
          html += @template.content_tag :div, class: "btn btn-primary btn-xs", data: { id: item.id().to_s} do
            hidden_options = {:value => item.id}
            hidden_options[:multiple] = true if options[:multiple]
            item_html = hidden_field fk_method, hidden_options
            item_html += item.send(name_method)
            item_html += @template.content_tag :a, href: '#' do
              @template.content_tag :span, '', class: "glyphicon glyphicon-remove"
            end
            item_html.html_safe
          end
        end
        html.html_safe
      end
    end

    def search_select_input_group(method)
      @template.content_tag :div, class: 'select-input-group', data: {'toggle' => "dropdown"} do
        html = @template.content_tag :div, class: 'select-input' do
          @template.text_field_tag(:search_val, nil, class: '')
        end
        html += @template.content_tag(:span, '', class: 'caret')
        html.html_safe
      end
    end

    def search_select_dropdown_menu(id)
      @template.content_tag :ul, '', class: 'dropdown-menu', id: "dropdown-menu-#{id}"
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
    options[:builder] = ApplicationFormBuilder
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
