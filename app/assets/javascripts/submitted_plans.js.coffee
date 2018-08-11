$(document).ready ->
  $("#submitted_plan_form").validate()

  add_fields = (link, association, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp("new_" + association, "g")
    $("table").append content.replace(regexp, new_id)
  
  remove_fields = (link) ->
    $(link).prev("input[type=hidden]").val "1"
    $(link).closest("tr").hide()
