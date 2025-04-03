String validatePassword(String password) {
  String result = '';

  // Password length greater than 6
  if (password.length < 6) {
    result += 'Password must be longer than 6 characters.\n';
  }

  // Contains at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    result += '• Uppercase letter is missing.\n';
  }

  // Contains at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    result += '• Lowercase letter is missing.\n';
  }

  // Contains at least one digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    result += '• Digit is missing.\n';
  }

  // Contains at least one special character
  if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
    result += '• Special character is missing.\n';
  }

  // If there are no error messages, the password is valid
  return result;
}
