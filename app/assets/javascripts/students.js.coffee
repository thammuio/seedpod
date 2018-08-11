$(document).ready ->
  jQuery.validator.addMethod "multiemail", ((value, element) ->
    email = value.split(/[;,]+/)
    valid = true
    for i of email
      value = email[i]
      valid = valid and jQuery.validator.methods.email.call(this, $.trim(value), element)
    valid
  ), jQuery.validator.messages.multiemail
  $("#student_form").validate
    rules:
      'student[email]':
        multiemail: true
        required: true

    messages:
      'student[email]':
        multiemail: "You must enter a valid email, or comma separate multiple"

