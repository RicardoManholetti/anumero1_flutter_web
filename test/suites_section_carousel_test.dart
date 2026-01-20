import 'package:anumero1_flutter_web/presentation/sections/suites_section.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SuitesSection displays CarouselSlider on all screen sizes', (
    WidgetTester tester,
  ) async {
    // Force a specific size (desktop)
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: SuitesSection())),
      ),
    );

    // Use pump with duration instead of pumpAndSettle to avoid animation timeout
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CarouselSlider), findsOneWidget);

    // Reset view size
    tester.view.resetPhysicalSize();
  });

  testWidgets('SuitesSection displays CarouselSlider on mobile screen size', (
    WidgetTester tester,
  ) async {
    // Force mobile size
    tester.view.physicalSize = const Size(375, 812); // iPhone X dimensions
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: SuitesSection())),
      ),
    );

    // Use pump with duration instead of pumpAndSettle
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CarouselSlider), findsOneWidget);

    // Reset view size
    tester.view.resetPhysicalSize();
  });
}
