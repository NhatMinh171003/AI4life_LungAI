import 'dart:io';

DateTime parseDate(String dateString) {
  try {
    return HttpDate.parse(dateString);
  } catch (_) {
    return DateTime.now(); // hoặc xử lý fallback
  }
}
