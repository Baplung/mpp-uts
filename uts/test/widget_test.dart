import 'package:flutter_test/flutter_test.dart';
import 'package:uts/main.dart';

void main() {
  testWidgets('LokaTrip menampilkan halaman beranda', (tester) async {
    await tester.pumpWidget(const LokaTripApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('Selamat datang,'), findsOneWidget);
    expect(find.textContaining('Temukan tempat'), findsOneWidget);
  });
}
