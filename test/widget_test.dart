// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:bean_basket_web/main.dart';

void main() {
  testWidgets('Homepage renders cafe sections', (WidgetTester tester) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    addTearDown(() {
      VisibilityDetectorController.instance.updateInterval = const Duration(
        milliseconds: 500,
      );
    });

    await tester.pumpWidget(const BeanBasketApp());
    await tester.pump();

    expect(find.text('Bean Basket'), findsOneWidget);
    expect(find.text('Bean Basket\nGarden Cafe'), findsOneWidget);
    expect(find.text('Menu Highlights'), findsOneWidget);
    expect(find.text('Cafe Gallery'), findsOneWidget);
    expect(find.text('Find Bean Basket'), findsOneWidget);
  });
}
