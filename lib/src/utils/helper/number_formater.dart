import 'package:intl/intl.dart';

class NumberFormater {
  static String formatNumberWithIntl(int number) {
    final formatter = NumberFormat.compact();
    return formatter.format(number);
  }
}
