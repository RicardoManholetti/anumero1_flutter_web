import 'package:anumero1_flutter_web/presentation/sections/suites_section.dart';
import 'package:anumero1_flutter_web/presentation/widgets/suite_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
    // Use pump with duration instead of pumpAndSettle to avoid animation timeout
    await tester.pump(const Duration(milliseconds: 500));

    // Now uses CarouselSlider instead of Wrap
    expect(find.byType(CarouselSlider), findsOneWidget);
    expect(find.byType(SuiteCard), findsWidgets);
  });
}
