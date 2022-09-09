extension xDateTime on DateTime {
  String yearMonthDayFormat() {
    return "$year-${month < 10 ? "0$month" : month}-${day < 10 ? "0$day" : day}";
  }
}
