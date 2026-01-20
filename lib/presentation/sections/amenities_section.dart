import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_icon.dart'
    as custom;
import 'package:anumero1_flutter_web/presentation/widgets/magical_hover_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 48),
      color: const Color(0xFFF9F9F9),
      child: Column(
        children: [
          AnimatedEntry(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Estrutura',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedEntry(
            delay: const Duration(milliseconds: 100),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                children: [
                  const TextSpan(text: 'Tudo que Você '),
                  TextSpan(
                    text: 'Precisa',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedEntry(
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Estrutura completa para você aproveitar suas férias com conforto e tranquilidade.',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.text.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          // Compact centered grid
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800), // Limit width
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildAmenityItem(FontAwesomeIcons.water, 'Piscina', 300),
                  _buildAmenityItem(
                    FontAwesomeIcons.mugHot,
                    'Área de Convivência',
                    400,
                  ),
                  _buildAmenityItem(
                    FontAwesomeIcons.car,
                    'Estacionamento Grátis',
                    500,
                  ),
                  _buildAmenityItem(
                    FontAwesomeIcons.video,
                    'Monitoramento',
                    600,
                  ),
                  _buildAmenityItem(
                    FontAwesomeIcons.kitchenSet,
                    'Cozinha Compartilhada',
                    700,
                  ),
                  _buildAmenityItem(
                    FontAwesomeIcons.fireBurner,
                    'Churrasqueira',
                    800,
                  ),
                  _buildAmenityItem(
                    FontAwesomeIcons.locationDot,
                    'Ótima Localização',
                    900,
                  ),
                  _buildAmenityItem(
                    FontAwesomeIcons.banSmoking,
                    'Não Fumantes',
                    1000,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityItem(IconData icon, String title, int delayMs) {
    return AnimatedEntry(
      delay: Duration(milliseconds: delayMs),
      child: SizedBox(
        width: 140, // Smaller fixed width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Magical Circle Icon
            MagicalHoverCard(
              width: 80,
              height: 80,
              borderRadius: BorderRadius.circular(100),
              elevation: 6,
              spotlightColor: AppColors.primary.withValues(alpha: 0.5),
              child: Center(
                child: custom.AnimatedIcon(
                  icon: icon,
                  size: 28,
                  color: AppColors.primary,
                  hoverColor: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.deepSea,
                fontSize: 13,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
