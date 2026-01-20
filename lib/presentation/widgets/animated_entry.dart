import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedEntry extends StatelessWidget {
  final Widget child;
  final Duration delay;

  const AnimatedEntry({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: 800.ms, curve: Curves.easeInOut)
        .slideY(begin: 0.2, end: 0, duration: 800.ms, curve: Curves.easeInOut);
  }
}
