import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AnimatedEntry wraps child with Animate', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AnimatedEntry(child: Text('Test'))),
    );
    await tester.pumpAndSettle();
    expect(find.text('Test'), findsOneWidget);
    // Verifying it has animations (checking for Animate widget in tree)
    expect(find.byType(Animate), findsOneWidget);
  });
}
