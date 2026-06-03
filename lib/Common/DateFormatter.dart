class DateFormatter {
  // Static method to format the date
  static String convertDate(String date) {
    try {
      // Split the input date by the delimiter '-'
      List<String> parts = date.split('-');

      // Check if the date is in the correct format
      if (parts.length != 3) {
        return date;
      }

      // Extract year, month, and day
      String year = parts[0];
      String month = parts[1];
      String day = parts[2];

      // Return the formatted date
      return "$day-$month-$year";
    } catch (e) {
      // If any error occurs, return the original date string
      return date;
    }
  }
}
