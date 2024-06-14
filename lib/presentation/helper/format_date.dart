
import 'package:shamsi_date/shamsi_date.dart';

String formatDate(String dateTimeString) {
  final now = DateTime.now();
  final dateTime = DateTime.parse(dateTimeString).toLocal();
  final duration = now.difference(dateTime);

  if (duration.inMinutes < 60) {
    return '${duration.inMinutes} دقیقه قبل';
  }

  final today = DateTime(now.year, now.month, now.day);
  final yesterday = DateTime(now.year, now.month, now.day - 1);

  if (dateTime.isAfter(today)) {
    return 'امروز';
  } else if (dateTime.isAfter(yesterday)) {
    return 'دیروز';
  }

  final jalaliDate = Jalali.fromDateTime(dateTime);
  final nowJalali = Jalali.fromDateTime(now);

  if (jalaliDate.year == nowJalali.year) {
    return '${jalaliDate.day} ${jalaliDate.formatter.mN}';
  }

  return '${jalaliDate.day} ${jalaliDate.formatter.mN} ${jalaliDate.year}';
}