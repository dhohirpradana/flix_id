import 'package:intl/intl.dart';

extension IntExtension on int {
  String toIDRCurrencyFormat() =>
      NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0)
          .format(this);
}
