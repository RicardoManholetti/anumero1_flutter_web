import 'dart:ui';

import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/premium_button.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
  final Function(int)? onNavTap;
  final bool isScrolled;

  const NavBar({super.key, this.onNavTap, this.isScrolled = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 1200;
        final logoSize = isMobile
            ? (isScrolled ? 40.0 : 60.0)
            : (isScrolled ? 60.0 : 100.0);
        final horizontalPadding = isMobile ? 16.0 : 48.0;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isScrolled ? 12 : (isMobile ? 16 : 32),
          ),
          decoration: BoxDecoration(
            color: isScrolled
                ? AppColors.primary.withValues(alpha: 0.85)
                : Colors.transparent,
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
            child: BackdropFilter(
              filter: isScrolled
                  ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                  : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo - Responsive size
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: logoSize,
                    child: Image.asset(
                      'assets/images/logo_header.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Desktop: Full navigation
                  if (!isMobile)
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

                  // Mobile: Hamburger menu
                  if (isMobile) _MobileMenuButton(onNavTap: onNavTap),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openWhatsApp() {
    final message = Uri.encodeComponent('Olá! Gostaria de mais informações.');
    launchUrl(Uri.parse('https://wa.me/5511947243870?text=$message'));
  }
}

// Mobile hamburger menu button
class _MobileMenuButton extends StatelessWidget {
  final Function(int)? onNavTap;

  const _MobileMenuButton({this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: Colors.white),
      iconSize: 28,
      onPressed: () => _showMobileMenu(context),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primary,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final maxHeight = screenHeight * 0.55;

        return PointerInterceptor(
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Handle bar
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),

                      _MobileMenuItem(
                        title: 'INÍCIO',
                        icon: Icons.home_outlined,
                        onTap: () {
                          Navigator.pop(context);
                          onNavTap?.call(0);
                        },
                      ),
                      _MobileMenuItem(
                        title: 'ACOMODAÇÕES',
                        icon: Icons.hotel_outlined,
                        onTap: () {
                          Navigator.pop(context);
                          onNavTap?.call(1);
                        },
                      ),
                      _MobileMenuItem(
                        title: 'ESTRUTURA',
                        icon: Icons.pool_outlined,
                        onTap: () {
                          Navigator.pop(context);
                          onNavTap?.call(2);
                        },
                      ),
                      _MobileMenuItem(
                        title: 'LOCALIZAÇÃO',
                        icon: Icons.location_on_outlined,
                        onTap: () {
                          Navigator.pop(context);
                          onNavTap?.call(3);
                        },
                      ),
                      const SizedBox(height: 12),

                      // Reserve button
                      SizedBox(
                        width: double.infinity,
                        child: PremiumButton(
                          text: 'RESERVAR VIA WHATSAPP',
                          onPressed: () {
                            Navigator.pop(context);
                            final message = Uri.encodeComponent(
                              'Olá! Gostaria de mais informações.',
                            );
                            launchUrl(
                              Uri.parse(
                                'https://wa.me/5511947243870?text=$message',
                              ),
                            );
                          },
                          isPrimary: true,
                          compact: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.8,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withValues(alpha: 0.5),
              size: 14,
            ),
          ],
        ),
      ),
    );
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 1.5,
                  color: _isHovered ? AppColors.accent : Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 1,
                width: _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
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
