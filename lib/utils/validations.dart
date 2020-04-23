String validatePassword(String value) {
  if (value.length == 0) {
    return "Password can't be empty";
  } else if (value.length < 6) {
    return "Password length atleast 6 characters";
  } else {
    return null;
  }
}



String validateTextField(String value) {
  if (value.length == 0) {
    return "Field can't be empty";
  } else {
    return null;
  }
}

String validateEmail(String value) {
  if (value.length == 0) {
    return "Email or Phone can't be empty";
  } else if (!RegExp(r"^(?:9)?[0-9]{10}$").hasMatch(value)) {
//  } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//      .hasMatch(value)) {
    return "Email or phone invalid";
  } else {
    return null;
  }
}

String validateUserInput(String val) {
  if (val.length == 0) {
    return "Email or Phone can't be empty";
  } else if (validateMobile(val) | validateEmailAddress(val)) {
    return null;
  } else {
    return "Invalid Email or Phone";
  }
}

String validateUsername(String value) {
  if (value.length == 0) {
    return "Username can't be empty";
  } else {
    return null;
  }
}

bool validateNumber(String value) {
  if (value.length == 0 && value == null) {
    return false;
  } else if (RegExp(r"^(?:9)?[0-9]|").hasMatch(value)) {
    // Fimber.i("Input is number");
    return true;
  } else {
    return false;
  }
}

bool validateMobile(String value) {
  RegExp regExp = new RegExp(r"^(?:9)?[0-9]{10}$");
  if (value.isEmpty && value?.length == 0) {
    return false;
  } else if (regExp.hasMatch(value)) {
    return true;
  } else {
    return false;
  }
}

bool validateEmailAddress(String value) {
  if (value.isEmpty && value.length == 0) {
    return false;
  } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}

String validateResetEmailAddress(String email) {
  if (email.isEmpty && email.length == 0) {
    return "Email can't be empty";
  } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email)) {
    return "Invalid email address";
  } else {
    return null;
  }
}

String validateReminderTitle(String title) {
  if (title.isEmpty && title.length == 0) {
    return "Reminder title can't be empty";
  }
  return null;
}

String validateReminderDescription(String title) {
  if (title.isEmpty && title.length == 0) {
    return "Reminder description can't be empty";
  }
  return null;
}

String validateReminderTime(String title) {
  if (title.isEmpty && title.length == 0) {
    return "Reminder time can't be empty";
  }
  return null;
}

String validateReminderDate(String title) {
  if (title.isEmpty && title.length == 0) {
    return "Reminder date can't be empty";
  }
  return null;
}