$(document).ready ->
  $("#change_password").validate rules:
    password:
      required: true

    password:
      required: true
      minlength: 7

    password_confirmation:
      required: true
      minlength: 7
      equalTo: "#password"