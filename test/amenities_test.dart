import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anumero1_flutter_web/presentation/sections/amenities_section.dart';

void main() {
  testWidgets('AmenitiesSection renders features', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AmenitiesSection())),
    );
    await tester.pumpAndSettle();
    expect(find.text('Estrutura Completa'), findsOneWidget);
    expect(find.text('Piscina'), findsOneWidget);
    expect(find.text('Área Gourmet'), findsOneWidget);
  });
}
