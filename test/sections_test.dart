import 'package:anumero1_flutter_web/presentation/sections/hero_section.dart';
import 'package:anumero1_flutter_web/presentation/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HeroSection renders title', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HeroSection()));
    await tester.pumpAndSettle();
    expect(find.text('A Número 1 Suítes'), findsOneWidget);
  });

  testWidgets('NavBar renders navigation items', (tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: NavBar())));
    expect(find.text('Início'), findsOneWidget);
    expect(find.text('Acomodações'), findsOneWidget);
  });
}
