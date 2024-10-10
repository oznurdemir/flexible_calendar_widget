import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/src/flexible_calendar_widget.dart'; // Doğru yolu kontrol edin

void main() {
  testWidgets('FlexibleCalendarWidget should create', (WidgetTester tester) async {
    // Test widget'ınızı oluşturun
    final selectedDate = DateTime.now();

    // Widget'ı test ortamında oluşturun
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlexibleCalendarWidget(
            onDateSelected: (date) {
              // Tarih seçimi işlemleri
            }, selectedDate: selectedDate,
          ),
        ),
      ),
    );

    // Widget'ın oluşturulup oluşturulmadığını kontrol edin
    expect(find.byType(FlexibleCalendarWidget), findsOneWidget);

    // Ek testler ekleyebilirsiniz, örneğin, takvimde belirli bir metni kontrol etmek
    // expect(find.text('Takvim'), findsOneWidget); // Örnek
  });
}
