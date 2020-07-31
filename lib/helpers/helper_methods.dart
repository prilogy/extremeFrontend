class HelperMethods {
  static String DateToString(DateTime date) {
    var day = date.day < 10 ? '0${date.day}' : date.day;
    var month = date.month < 10 ? '0${date.month}' : date.month;
    return '$day.$month.${date.year}';
  }
}