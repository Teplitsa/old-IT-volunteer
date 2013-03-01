jQuery ->
  $('.task_type_preference, .prize_type_preference').change ->
    prefered_url = $(this).data('prefer-url')
    unprefered_url = $(this).data('unprefer-url')
    
    if $(this).is(':checked')
      $.ajax({url: prefered_url, type: 'PUT'})
    else
      $.ajax({url: unprefered_url, type: 'PUT'})