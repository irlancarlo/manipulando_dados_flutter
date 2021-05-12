import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper {

  static String formatDate(String date) {
    initializeDateFormatting("pt_BR");

    DateFormat dateFormat = DateFormat("d/MM/Y H:m:s");
    // DateFormat dateFormat = DateFormat.yMMM("pt_BR");
    DateTime dateTime = DateTime.parse(date);
    String result = dateFormat.format(dateTime);

    return result;
  }
}
