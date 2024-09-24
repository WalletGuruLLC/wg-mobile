import 'package:intl/intl.dart';

class Formatter {
  static String formatStringToUsFormat(String value) {
    if (value.isEmpty) {
      return '';
    }
    value = value.replaceAll('\$', '');

    final number = int.tryParse(value.replaceAll(',', ''));
    if (number == null) {
      return value;
    }
    final formatter = NumberFormat('#,##0', 'en_US');
    return '\$${formatter.format(number)}';
  }
}
