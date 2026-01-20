import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CinematicLoader extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const CinematicLoader({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<CinematicLoader> createState() => _CinematicLoaderState();
}

class _CinematicLoaderState extends State<CinematicLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _startLoadingSequence();
  }

  Future<void> _startLoadingSequence() async {
    // 1. Fade in logo
    await _controller.forward();

    // 2. Wait a bit
    await Future.delayed(widget.duration);

    // 3. Fade out loader
    if (mounted) {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main App Content (Always built behind, but hidden initially if desired)
        widget.child,

        // Loader Overlay
        if (_loading || _controller.isAnimating)
          IgnorePointer(
            ignoring:
                !_loading, // Pass touches once loading checks are done (handling fade out)
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: _loading ? 1.0 : 0.0,
              curve: Curves.easeInOut,
              child: Container(
                color: AppColors.champagne,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _opacity.value,
                        child: Transform.scale(
                          scale: _scale.value,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/logo_header.png',
                                width: 200,
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.primary,
                                  ),
                                  strokeWidth: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
