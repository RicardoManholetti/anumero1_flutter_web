import 'package:flutter/material.dart';

class HoverLiftCard extends StatefulWidget {
  final Widget child;
  final double width;

  const HoverLiftCard({super.key, required this.child, this.width = 350});

  @override
  State<HoverLiftCard> createState() => _HoverLiftCardState();
}

class _HoverLiftCardState extends State<HoverLiftCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Smoother
        curve: Curves.easeOutCubic, // Elegant curve
        width: widget.width,
        transform: _isHovered
            ? (Matrix4.identity()
                ..translate(0.0, -8.0)) // Lift up instead of scale
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0), // Sharp luxury corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.2 : 0.05),
              blurRadius: _isHovered ? 30 : 10, // Softer, deeper shadow
              offset: Offset(0, _isHovered ? 15 : 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: widget.child,
        ),
      ),
    );
  }
}
