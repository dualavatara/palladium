@resize_children_max = ->
  $('[data-child-maxwidth]').each ->
    maxWidth = $(this).outerWidth()
    $(this).find('*').each ->
      if $(this).outerWidth() > maxWidth
        maxWidth = $(this).outerWidth()
    $(this).outerWidth(maxWidth)
    $(this).children('*').outerWidth(maxWidth)

$(document).on "page:change", @resize_children_max


