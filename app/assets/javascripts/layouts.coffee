@resize_children_max = ->
  $('[data-child-maxwidth]').each ->
    maxWidth = $(this).outerWidth() + 1
    $(this).find('*').each ->
      if $(this).outerWidth() > maxWidth
        maxWidth = $(this).outerWidth()
    $(this).outerWidth(maxWidth)
    $(this).children('ul').outerWidth(maxWidth)

$(document).on "page:change", @resize_children_max


