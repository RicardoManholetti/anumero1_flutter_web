import 'dart:ui';

import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/premium_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  final bool isScrolled;

  const NavBar({super.key, this.onNavTap, this.isScrolled = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: 48,
        vertical: isScrolled ? 12 : 32, // Shrink vertically
      ),
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.primary.withValues(alpha: 0.85)
            : Colors.transparent, // Transparent at top
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        // For blur effect if needed, though BackdropFilter is better used outside or full container
        child: BackdropFilter(
          filter: isScrolled
              ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
              : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Logo Image - Animate size
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isScrolled ? 60 : 100,
                    child: Image.asset(
                      'assets/images/logo_header.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              if (MediaQuery.of(context).size.width > 800)
                Row(
                  children: [
                    _NavItem(
                      title: 'INÍCIO',
                      onTap: () => onNavTap?.call(0),
                      isScrolled: isScrolled,
                    ),
                    _NavItem(
                      title: 'ACOMODAÇÕES',
                      onTap: () => onNavTap?.call(1),
                      isScrolled: isScrolled,
                    ),
                    _NavItem(
                      title: 'ESTRUTURA',
                      onTap: () => onNavTap?.call(2),
                      isScrolled: isScrolled,
                    ),
                    _NavItem(
                      title: 'LOCALIZAÇÃO',
                      onTap: () => onNavTap?.call(3),
                      isScrolled: isScrolled,
                    ),
                    const SizedBox(width: 32),
                    PremiumButton(
                      text: 'RESERVAR',
                      onPressed: _openWhatsApp,
                      isPrimary: true,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openWhatsApp() {
    final message = Uri.encodeComponent('Olá! Gostaria de mais informações.');
    launchUrl(Uri.parse('https://wa.me/5511947243870?text=$message'));
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isScrolled;

  const _NavItem({required this.title, this.onTap, this.isScrolled = false});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // More spacing
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 1.5, // Uppercase tracking
                  color: _isHovered ? AppColors.accent : Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1, // Thinner line
                width: _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent, // Sand Orange underline
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
