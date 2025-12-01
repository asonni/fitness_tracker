class Validators {
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name is required';
    }

    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    // check if this empty or not
    if (email == null || email.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    return emailRegex.hasMatch(email) ? null : 'Please enter a valid email';
  }

  static String? validatePasswordStrong(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Password is required';
    }

    // A strong password has at least 8 characters, including uppercase, lowercase, number, and special character
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    return passwordRegex.hasMatch(password)
        ? null
        : 'Password must be at least 8 characters, include uppercase, lowercase, number, and special character';
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'Confirm Password is required';
    }

    return password == confirmPassword ? null : 'Passwords do not match';
  }

  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (phone.length < 10) {
      return 'Phone number must be at least 10 digts';
    }

    final phoneRegex = RegExp(r'^09[1-5]\d{7}$');

    return phoneRegex.hasMatch(phone)
        ? null
        : 'Phone number must starts with 091, 092, 093, 094, or 095';
  }
}
