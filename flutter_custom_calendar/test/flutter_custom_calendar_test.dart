import 'package:flutter_test/flutter_test.dart';
import '../lib/flutter_custom_calendar.dart';

void main() {
  test('CustomCalendar widget should create', () {
    // CustomCalendar widget'ı ile ilgili bir test ekleyin.
    late DateTime selectedDate = DateTime.now();
    final calendar = FlutterCustomCalendar(selectedDate: selectedDate);
    expect(calendar, isNotNull); // Örnek bir kontrol
  });
}
