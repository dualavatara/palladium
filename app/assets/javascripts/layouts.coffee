@resize_children_max = ->
  $('[data-same-width]').each ->
    maxWidth = $(this).outerWidth() + 1
    target = $('#' + $(this).data('sameWidth'))
    if target.outerWidth() > maxWidth
      maxWidth = target.outerWidth() + 1

    $(this).outerWidth(maxWidth)
    target.outerWidth(maxWidth)


$(document).on "page:change", @resize_children_max
$(document).on "page:change", ->
  $(".search-select #search_val").on 'input', (event) ->
    alert $(event.target).val()


