class Validators {
  static String? nonEmpty(String? v) =>
      (v == null || v.isEmpty) ? 'This field is required' : null;

  static String? phone(String? v) {
    if (v == null || v.isEmpty) return 'This field is required';
    final regex = RegExp(r'^\+?[0-9]{7,15}$');
    return regex.hasMatch(v) ? null : 'Enter a valid phone number';
  }
}
