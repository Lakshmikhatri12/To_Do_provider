class AppValidators {
  static String? email(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required';
    }
    if (val.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? confirmPassword(String? val, String password) {
    if (val == null || val.isEmpty) {
      return 'Please confirm your password';
    }
    if (val != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? username(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Username is required';
    }
    if (val.trim().length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  // ─── Name ───────────────────────────────────
  static String? name(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'This field is required';
    }
    if (val.trim().length < 2) {
      return 'Must be at least 2 characters';
    }
    return null;
  }

  // ─── Required ───────────────────────────────
  static String? required(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }
}
