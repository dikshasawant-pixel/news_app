import 'package:flutter/cupertino.dart';
import 'package:news_app/Model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Listview scroll test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final listview = find.byType(ListView);

    await tester.fling(listview, Offset(0, 0), 0);
    await tester.pumpAndSettle();
  });
}
