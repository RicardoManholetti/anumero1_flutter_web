import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppFab extends StatefulWidget {
  const WhatsAppFab({super.key});

  @override
  State<WhatsAppFab> createState() => _WhatsAppFabState();
}

class _WhatsAppFabState extends State<WhatsAppFab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 24,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: _openWhatsApp,
          child:
              AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(_isHovered ? 18 : 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF25D366),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF25D366,
                          ).withValues(alpha: _isHovered ? 0.5 : 0.3),
                          blurRadius: _isHovered ? 24 : 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 28,
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    delay: 2000.ms,
                    duration: 1500.ms,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
        ),
      ),
    );
  }

  void _openWhatsApp() {
    final message = Uri.encodeComponent(
      'Olá! Gostaria de mais informações sobre as suítes.',
    );
    launchUrl(Uri.parse('https://wa.me/5511947243870?text=$message'));
  }
}
