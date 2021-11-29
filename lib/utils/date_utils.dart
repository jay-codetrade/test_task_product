import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateConstants {
  static const String apiDateFormat = "yyyy-MM-dd HH:mm:ss";
  static const String dateFormat = "dd-MM-yyyy";
  static const String displayDateFormat = "dd MMMM yyyy";
  static const String threadDateFormat = "dd MMM yyyy";
  static const String timeFormat = "hh:mm a";
  static const String notificationDateFormat = "dd/MM";
  static const String notificationTimeFormat = "H:mm";
}

String getCurrentDateString(String dateFormat) {
  initializeDateFormatting();
  return DateFormat(dateFormat).format(DateTime.now()).toString();
}

String getUtcDate() {
  var dateUtc = DateTime.now().toUtc();
  var date = DateFormat(DateConstants.apiDateFormat).format(dateUtc);
  return date;
}

String getLocalTime(String dateUtc) {
  initializeDateFormatting();
  var dateTime = DateFormat(DateConstants.apiDateFormat).parse(dateUtc, true);
  var dateLocal = dateTime.toLocal();
  return DateFormat(DateConstants.timeFormat)
      .format(dateLocal)
      .replaceAll(' ', '')
      .toLowerCase();
}

String formatDate(String date,
    {String dateFormat = DateConstants.displayDateFormat}) {
  initializeDateFormatting();
  var dateTime = DateFormat(DateConstants.apiDateFormat).parse(date, true);
  var dateLocal = dateTime.toLocal();
  return DateFormat(dateFormat).format(dateLocal);
}

String formatTime(DateTime date,
    {String dateFormat = DateConstants.timeFormat}) {
  initializeDateFormatting();
  var time = DateFormat(DateConstants.timeFormat).format(date);
  return time;
}

String parseDate(String dateUtc, {bool returnDate = false}) {
  initializeDateFormatting();
  var date = DateFormat(DateConstants.apiDateFormat).parse(dateUtc, true);
  var dateLocal = date.toLocal();
  var formattedDate =
      DateFormat("${DateConstants.dateFormat}").format(dateLocal);
  var currentDate = DateFormat(DateConstants.dateFormat).format(DateTime.now());
  if (formattedDate == currentDate) {
    return DateFormat(returnDate
            ? DateConstants.displayDateFormat
            : DateConstants.timeFormat)
        .format(dateLocal)
        .replaceAll(' ', '')
        .toLowerCase();
  }
  return DateFormat(DateConstants.threadDateFormat).format(dateLocal);
}
