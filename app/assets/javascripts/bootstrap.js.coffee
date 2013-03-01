window.x_editable_tag_display = (value, sourceData)->
  result = ''
  jQuery(value.split(',')).each (index, value)->
    result += '<span class="label label-info">' + value + '</span>&nbsp;'

  jQuery(this).html result

jQuery ->
  jQuery ->
  window.prettyPrint and prettyPrint()
  jQuery("#dp3").datepicker()
  
  jQuery(".edit-inplace, .x-editable-inplace").each (index, el)->
    element = jQuery(el)
    if element.hasClass('tags')
      element.editable({display : x_editable_tag_display, separator: ','})
      element.on 'shown', ->
        tip = jQuery(this).data('editableContainer').tip()
        
        arr = element.find('span').map (_,b)->
          jQuery(b).text()
        tip.find('input').val(arr.toArray().join(','))
    else
      element.editable()

  jQuery(".west").tipsy gravity: "w"
  jQuery("a[rel=popover]").popover()
  jQuery(".tooltip").tooltip()
  jQuery("a[rel=tooltip]").tooltip()
  jQuery('#tabs-task a:first').tab('show');
  jQuery("#check-all").click ->
    if jQuery("#check-all").attr("checked")
      jQuery(".check-one").attr "checked", true
    else
      jQuery(".check-one").attr "checked", false
  jQuery('.filter-select').customSelect();
  jQuery(".change-logo").on "click", ->
    jQuery("#organization_logo").click()
    false

  jQuery("#myTab a").click (e) ->
    e.preventDefault()
    jQuery(this).tab "show"

  $(document).ready ->
    $("#check_all").click ->
      unless $("#check_all").is(":checked")
        $(".checked").removeAttr "checked"
      else
        $(".checked").attr "checked", "checked"    