import 'package:flutter/material.dart';

/// Wraps a child widget to apply parallax scrolling effect.
/// The child moves at a different rate than the scroll.
class ParallaxWrapper extends StatefulWidget {
  final Widget child;
  final double parallaxFactor;
  final ScrollController? scrollController;

  const ParallaxWrapper({
    super.key,
    required this.child,
    this.parallaxFactor = 0.3,
    this.scrollController,
  });

  @override
  State<ParallaxWrapper> createState() => _ParallaxWrapperState();
}

class _ParallaxWrapperState extends State<ParallaxWrapper> {
  double _offset = 0;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateOffset();
    });
  }

  void _updateOffset() {
    final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      // Calculate offset based on position in viewport
      final viewportCenter = screenHeight / 2;
      final elementCenter = position.dy + (renderBox.size.height / 2);
      final distanceFromCenter = elementCenter - viewportCenter;

      setState(() {
        _offset = distanceFromCenter * widget.parallaxFactor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _updateOffset();
        return false;
      },
      child: Transform.translate(
        key: _key,
        offset: Offset(0, _offset),
        child: widget.child,
      ),
    );
  }
}
