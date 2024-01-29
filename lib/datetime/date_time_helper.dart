// convert DateTime object to a string ddmmyyyy
// ignore_for_file: prefer_interpolation_to_compose_strings

String convertDateTimeToString(DateTime dateTime) {
  // year in the format -> yyyy
  String year = dateTime.year.toString();

  // month in the format -> mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0' + month;
  }

  // day in the format -> dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0' + day;
  }

  // final format -> ddmmyyyy
  String ddmmyyyy = day + month + year;

  return ddmmyyyy;
}