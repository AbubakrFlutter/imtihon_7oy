import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imtihon_7/main.dart';

void main() {
  testWidgets('App starts with splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TapTapApp(),
      ),
    );

    expect(find.text('TapTap'), findsOneWidget);
    expect(find.text('to Share Your Games'), findsOneWidget);
  });
}
