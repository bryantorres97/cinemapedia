import 'package:intl/intl.dart' show NumberFormat;

class HumanFormats {
  static String formatNumber(double number, [int decimalDigits = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en_US',
    ).format(number);

    return formattedNumber;
  }
}
