// lib/core/validators.dart

class AppValidators {
  // ── Name ──
  static String? name(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Name is required';
    }
    if (val.trim().length < 3) {
      return 'Name atleast contain 3 letters';
    }
    if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(val.trim())) {
      return 'Name can only have letters';
    }
    return null; // sab theek
  }

  // ── Email ──
  static String? email(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    ).hasMatch(val.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  // ── Password ──
  static String? password(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // ── Confirm Password ──
  static String? confirmPassword(String? val, String originalPassword) {
    if (val == null || val.trim().isEmpty) {
      return 'Re-enter password';
    }
    if (val != originalPassword) {
      return 'Password does not match';
    }
    return null;
  }
}
