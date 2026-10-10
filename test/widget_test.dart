import 'package:flutter_test/flutter_test.dart';
import 'package:prj/app.dart';

void main() {
  testWidgets('MediLearnApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MediLearnApp());
    expect(find.byType(MediLearnApp), findsOneWidget);
  });
}
