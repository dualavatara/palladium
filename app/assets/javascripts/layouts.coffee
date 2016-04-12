@resize_children_max = ->
  $('[data-same-width]').each ->
    maxWidth = $(this).outerWidth() + 1
    target = $('#' + $(this).data('sameWidth'))
    if target.outerWidth() > maxWidth
      maxWidth = target.outerWidth() + 1

    $(this).outerWidth(maxWidth)
    target.outerWidth(maxWidth)

del_item = (control, id) ->
  control.find('.selected-items div[data-id=' + id + ']').remove()

add_item = (control, id, name) ->
  if !control.id_selected(id)
    if control.data("multiple")
      hidden = '<input multiple="multiple" value="' + id + '" type="hidden" name="' + control.data("name") + '[]" id="' + control.data("id") + '">'
    else
      hidden = '<input value="' + id + '" type="hidden" name="' + control.data("name") + '" id="' + control.data("id") + '">'

    item = $('<div class="btn btn-primary btn-xs" data-id="' + id + '">' + hidden + name + '<a href="#"><span class="glyphicon glyphicon-remove"></span></a></div>')
    item.find('a').on('click', {id: id}, (event) ->
      del_item control, event.data.id
    )
    if !control.data("multiple")
      control.find('.selected-items').empty()
    control.find('.selected-items').append(item)


$(document).on "page:change", @resize_children_max
$(document).on "page:change", ->
  $("div.search-select").each(->
    control = $(this)
    control.id_selected = (id) ->
      selected = false
      control.find('.selected-items [type=hidden]').each(->
        selected = true if $(this).val() == id
      )
      return selected

    url = $(this).data("searchPath")

    request_search_select = (event) ->
      value = $(this).val()
      $.getJSON(url, {val: value}).fail((jqXHR, textStatus, errorThrown) ->
        alert textStatus
      ).done((data) ->
        html = ""
        $.each(data, (idx, item) ->
          html += '<li data-id="' + item.id + '"><a href="#">' + item.name + '</a></li>'
        )
        control.find('ul.dropdown-menu').empty().html(html)
        control.find('ul.dropdown-menu li').on('click', (event) ->
          add_item control, $(this).data("id"), $(this).text()
        )
      )

    control.find('.selected-items div').each(->
      id = $(this).data('id')
      $(this).find('a').on('click', {id: id}, (event) ->
        del_item control, event.data.id
      )
    )

    $(this).find("#search_val").on('input', request_search_select)
    $(this).find(".select-input-group").on('click', request_search_select)
  )



