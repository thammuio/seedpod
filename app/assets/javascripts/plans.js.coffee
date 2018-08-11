$(document).ready ->
  $("#request_plan").validate
    rules:
      "plan[team_ids][]":
        required: true

    messages:
      "plan[team_ids][]":
        required: "Please select atleast one team to create a plan!"

    errorPlacement: (error, element) ->
      errorCheckbox = undefined
      if element.attr("type") is "checkbox"
        errorCheckbox = document.getElementById("select_one_chk_box")
        error.appendTo $("#select_one_chk_box")
      else
        error.insertAfter element
      return