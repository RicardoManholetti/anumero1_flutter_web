import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PremiumButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool compact;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.compact = false,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = widget.compact ? 20.0 : 32.0;
    final verticalPadding = widget.compact ? 12.0 : 16.0;
    final fontSize = widget.compact ? 12.0 : 14.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: widget.isPrimary ? AppColors.accent : Colors.transparent,
            border: Border.all(color: AppColors.accent, width: 1.5),
            borderRadius: BorderRadius.circular(30),
            boxShadow: _isHovered && widget.isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.text.toUpperCase(),
                  style: TextStyle(
                    color: widget.isPrimary ? Colors.white : AppColors.accent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: widget.compact ? 0.8 : 1.5,
                    fontSize: fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.only(left: _isHovered ? 12 : 8),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: widget.compact ? 10 : 12,
                  color: widget.isPrimary ? Colors.white : AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
