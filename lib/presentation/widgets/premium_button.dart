import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PremiumButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const PremiumButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Slower, premium feel
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ), // More breathing room
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? AppColors.accent
                : Colors.transparent, // Sand Orange for CTA
            border: Border.all(color: AppColors.accent, width: 1.5),
            borderRadius: BorderRadius.circular(30), // Rounded, premium feel
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
            children: [
              Text(
                widget.text.toUpperCase(),
                style: TextStyle(
                  color: widget.isPrimary ? Colors.white : AppColors.accent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5, // Editorial tracking
                  fontSize: 14,
                ),
              ),
              AnimatedPadding(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.only(left: _isHovered ? 12 : 8),
                child: Icon(
                  Icons.arrow_forward_ios, // Sleek chevron instead of arrow
                  size: 12,
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
