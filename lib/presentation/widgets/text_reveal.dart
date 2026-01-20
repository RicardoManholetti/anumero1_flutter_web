import 'package:flutter/material.dart';

/// Reveals text character by character with a typing effect.
/// Great for headlines and impactful statements.
class TextReveal extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration charDuration;
  final Duration startDelay;
  final TextAlign textAlign;

  const TextReveal({
    super.key,
    required this.text,
    this.style,
    this.charDuration = const Duration(milliseconds: 40),
    this.startDelay = Duration.zero,
    this.textAlign = TextAlign.start,
  });

  @override
  State<TextReveal> createState() => _TextRevealState();
}

class _TextRevealState extends State<TextReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charAnimation;

  @override
  void initState() {
    super.initState();
    final totalDuration = widget.charDuration * widget.text.length;

    _controller = AnimationController(vsync: this, duration: totalDuration);

    _charAnimation = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.startDelay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charAnimation,
      builder: (context, child) {
        final visibleText = widget.text.substring(0, _charAnimation.value);
        return Text(
          visibleText,
          style: widget.style,
          textAlign: widget.textAlign,
        );
      },
    );
  }
}
