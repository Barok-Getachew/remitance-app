class StringHelper {
  static String obfuscateEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;

    final domain = parts[1];
    final name = parts[0];
    final hiddenName = '*' * name.length;

    return '$hiddenName@$domain';
  }
}
