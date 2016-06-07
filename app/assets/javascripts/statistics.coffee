$ ->
  $('.statistics-table tbody tr').click ->
    url = $(this).attr('data-url')
    window.location.href = url