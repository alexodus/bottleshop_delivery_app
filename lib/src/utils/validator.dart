class Validator {
  String email(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email is invalid';
    } else {
      return null;
    }
  }

  String password(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Password is too short';
    } else {
      return null;
    }
  }

  String passwordsMatch(String value1, String value2) {
    if (value1 != value2) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  }

  String name(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Name is invalid';
    } else {
      return null;
    }
  }

  String number(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Value is not a number';
    } else {
      return null;
    }
  }

  String amount(String value) {
    Pattern pattern = r'^\d+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Amount is incorrect';
    } else {
      return null;
    }
  }

  String notEmpty(String value) {
    Pattern pattern = r'^\S+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Field is not empty';
    } else {
      return null;
    }
  }
}
