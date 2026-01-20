import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anumero1_flutter_web/presentation/sections/gallery_section.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  testWidgets('GallerySection displays CarouselSlider on desktop', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: GallerySection())),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CarouselSlider), findsOneWidget);

    tester.view.resetPhysicalSize();
  });

  testWidgets('GallerySection displays CarouselSlider on mobile', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: GallerySection())),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CarouselSlider), findsOneWidget);

    tester.view.resetPhysicalSize();
  });
}
