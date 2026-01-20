import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MagicalHoverCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? spotlightColor;
  final double elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const MagicalHoverCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.spotlightColor,
    this.elevation = 4,
    this.borderRadius,
    this.onTap,
  });

  @override
  State<MagicalHoverCard> createState() => _MagicalHoverCardState();
}

class _MagicalHoverCardState extends State<MagicalHoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Alignment _mouseAlignment = Alignment.center;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
      if (isHovered) {
        _controller.forward();
      } else {
        _controller.reverse();
        _mouseAlignment = Alignment.center; // Reset alignment on exit
      }
    });
  }

  void _updateMouseRegion(PointerEvent details, Size size) {
    if (!_isHovered) return;

    // Calculate alignment from -1.0 to 1.0 based on mouse position
    final x = (details.localPosition.dx / size.width) * 2 - 1;
    final y = (details.localPosition.dy / size.height) * 2 - 1;

    setState(() {
      _mouseAlignment = Alignment(x, y);
    });
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ?? BorderRadius.circular(16);

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      onHover: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          _updateMouseRegion(details, box.size);
        }
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // 3D Tilt Effect calculations
            // Max rotation is small (e.g. 0.05 radians)
            final tiltX = _isHovered ? -_mouseAlignment.y * 0.05 : 0.0;
            final tiltY = _isHovered ? _mouseAlignment.x * 0.05 : 0.0;
            final scale = 1.0 + (_controller.value * 0.02); // Subtle scale up

            return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..rotateX(tiltX)
                ..rotateY(tiltY)
                ..scale(scale),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: widget.backgroundColor ?? Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.05 + (_controller.value * 0.1),
                      ),
                      blurRadius: widget.elevation + (_controller.value * 10),
                      offset: Offset(0, 4 + (_controller.value * 8)),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: borderRadius,
                  child: Stack(
                    children: [
                      // Content
                      widget.child,

                      // Spotlight Gradient Overlay
                      if (_isHovered)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    (widget.spotlightColor ?? AppColors.accent)
                                        .withValues(alpha: 0.15),
                                    Colors.transparent,
                                  ],
                                  center: _mouseAlignment,
                                  radius: 1.2,
                                  stops: const [0.0, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Specular Highlight (Reflection)
                      if (_isHovered)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.1),
                                    Colors.transparent,
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.4, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
