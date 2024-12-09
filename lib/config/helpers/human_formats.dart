import 'package:intl/intl.dart' show NumberFormat;

class HumanFormats {
  static String formatNumber(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en_US',
    ).format(number);

    return formattedNumber;
  }
}
