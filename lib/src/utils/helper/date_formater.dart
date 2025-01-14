import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  Duration diff = DateTime.now().difference(date);

  if (diff.inDays >= 365) {
    int years = diff.inDays ~/ 365;
    return '${years}y ago';
  } else if (diff.inDays >= 30) {
    int months = diff.inDays ~/ 30;
    return '${months}mo ago';
  } else if (diff.inDays >= 7) {
    int weeks = diff.inDays ~/ 7;
    return '${weeks}w ago';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays}d ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours}h ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes}min ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds}s ago';
  } else {
    return 'just now';
  }
}

String formatTime(String rawTime) {
  final DateTime dateTime = DateTime.parse(rawTime);
  return formatDate(dateTime);
}

String formatUserDate(DateTime date) {
  return DateFormat('MMM dd, yyyy').format(date);
}

DateTime? parseDateTime(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
  return null; // Return null if it's an unsupported type
}
