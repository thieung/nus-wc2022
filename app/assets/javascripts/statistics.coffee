$ ->
  $('.statistics-table tbody tr, .top-stat-tbl-clickable tbody tr, .top-stat-tbl tbody tr').click ->
    url = $(this).attr('data-url')
    window.location.href = url