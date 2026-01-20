import 'package:anumero1_flutter_web/presentation/sections/suites_section.dart';
import 'package:anumero1_flutter_web/presentation/widgets/suite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SuitesSection renders suite cards', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SuitesSection())),
    );
    await tester.pumpAndSettle();
    expect(find.text('Nossas Suítes'), findsOneWidget);
    expect(find.byType(SuiteCard), findsWidgets);
  });
}
