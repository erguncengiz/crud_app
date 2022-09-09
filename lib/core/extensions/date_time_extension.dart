extension xDateTime on DateTime {
  String yearMonthDayFormat() {
    return "${day < 10 ? "0$day" : day}/${month < 10 ? "0$month" : month}/$year";
  }
}
