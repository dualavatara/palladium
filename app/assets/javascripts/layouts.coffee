@resize_children_max = ->
  $('[data-child-maxwidth]').each ->
    maxWidth = $(this).width()
    $(this).find('*').each ->
      if $(this).width() > maxWidth
        maxWidth = $(this).width()
    $(this).width(maxWidth)

$(document).on "page:change", @resize_children_max


