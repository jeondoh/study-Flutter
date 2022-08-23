class Utils {
  static int getFormatTime(DateTime date) {
    return int.parse(
        '${date.year}${makeTwoDigit(date.month)}${makeTwoDigit(date.day)}');
  }

  static DateTime numToDateTime(int date) {
    String dateStr = date.toString();
    int year = int.parse(dateStr.substring(0, 4));
    int month = int.parse(dateStr.substring(4, 6));
    int day = int.parse(dateStr.substring(6, dateStr.length));
    return DateTime(year, month, day);
  }

  static String makeTwoDigit(int num) {
    return num.toString().padLeft(2, '0');
  }
}
