$(document).ready ->
  $("#team").validate
    rules:
      "team[student_ids][]":
        required: true

    messages:
      "team[student_ids][]":
        required: "Please select atleast one student to create a team!"

    errorPlacement: (error, element) ->
      errorCheckbox = undefined
      if element.attr("type") is "checkbox"
        errorCheckbox = document.getElementById("select_one_chk_box")
        error.appendTo $("#select_one_chk_box")
      else
        error.insertAfter element
      return

  return