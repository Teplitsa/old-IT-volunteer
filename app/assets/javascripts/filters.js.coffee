jQuery ->
  jQuery('.form-search').submit ->
    paramObj = {}
    
    jQuery('.form-search').each (_, el)->
      element = jQuery(el)

      jQuery.each element.serializeArray(), (_, kv)-> 
        paramObj[kv.name] = kv.value if kv.value? and kv.value != ''

    window.location.href = window.location.pathname.substring( 0, window.location.pathname.lastIndexOf( '/' )) + '?' + $.param(paramObj)
    false