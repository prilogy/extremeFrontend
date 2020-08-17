class HelperMethods {
  static String dateToString(DateTime date) {
    var day = date.day < 10 ? '0${date.day}' : date.day;
    var month = date.month < 10 ? '0${date.month}' : date.month;
    return '$day.$month.${date.year}';
  }

  static String capitalizeString(String str) {
    return "${str[0].toUpperCase()}${str.substring(1)}";
  }
}