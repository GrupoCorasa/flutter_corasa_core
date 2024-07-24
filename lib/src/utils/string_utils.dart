import 'package:intl/intl.dart';

class StringUtils {
  const StringUtils._();

  static final DateFormat _dateFormatter = DateFormat('dd-MM-yyyy');
  static final NumberFormat _numberFormat =
      NumberFormat('###,###,###.##', 'es_MX');
  static final NumberFormat _currencyFormat =
      NumberFormat('\$ ###,###,###.00', 'es_MX');

  static String getIniciales(String? name) {
    List<String> names = name?.split(' ') ?? ['¿', '?'];
    return names.map((e) => e.substring(0, 1).toUpperCase()).join();
  }

  static String parseDate(DateTime date) => _dateFormatter.format(date);

  static String parseCurrency(double value) => _currencyFormat.format(value);

  static String parseNumber(num value) => _numberFormat.format(value);
}
