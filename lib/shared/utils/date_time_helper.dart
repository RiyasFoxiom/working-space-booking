import 'package:intl/intl.dart';


String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String getTimeAgo(String time) {
  final dateTimeUpdated = DateTime.parse(time);
  final now = DateTime.now();
  Duration diff = now.difference(dateTimeUpdated);

  final years = diff.inDays ~/ 365;
  final months = (diff.inDays % 365) ~/ 30;

  if (years >= 1) {
    if (months >= 6) {
      final totalMonths = (years * 12) + months;
      return totalMonths == 1
          ? '$totalMonths month ago'
          : '$totalMonths months ago';
    }

    return years == 1 ? '$years year ago' : '$years years ago';
  } else if (months >= 1) {
    return months == 1 ? '$months month ago' : '$months months ago';
  } else if (diff.inDays >= 1) {
    return '${diff.inDays} days ago';
  } else if (diff.inHours >= 1) {
    if (diff.inHours > 12) {
      final days = diff.inHours ~/ 12;
      return days == 1 ? '$days day ago' : '$days days ago';
    }

    return '${diff.inHours} hr ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} min ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} sec ago';
  } else {
    return time;
  }
}