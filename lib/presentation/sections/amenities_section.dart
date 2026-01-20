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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final horizontalPadding = isMobile ? 16.0 : 48.0;
        final verticalPadding = isMobile ? 48.0 : 80.0;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          color: const Color(0xFFF9F9F9),
          child: Column(
            children: [
              AnimatedEntry(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
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
                      fontSize: isMobile ? 24 : null,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
                  child: Text(
                    'Estrutura completa para você aproveitar suas férias com conforto e tranquilidade.',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 18,
                      color: AppColors.text.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),
              // Compact centered grid
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 400 : 800),
                  child: Wrap(
                    spacing: isMobile ? 12 : 24,
                    runSpacing: isMobile ? 12 : 24,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildAmenityItem(
                        FontAwesomeIcons.water,
                        'Piscina',
                        300,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.mugHot,
                        'Área de Convivência',
                        400,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.car,
                        'Estacionamento Grátis',
                        500,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.video,
                        'Monitoramento',
                        600,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.kitchenSet,
                        'Cozinha Compartilhada',
                        700,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.fireBurner,
                        'Churrasqueira',
                        800,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.locationDot,
                        'Ótima Localização',
                        900,
                        isMobile,
                      ),
                      _buildAmenityItem(
                        FontAwesomeIcons.banSmoking,
                        'Não Fumantes',
                        1000,
                        isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmenityItem(
    IconData icon,
    String title,
    int delayMs,
    bool isMobile,
  ) {
    final itemWidth = isMobile ? 100.0 : 140.0;
    final iconSize = isMobile ? 60.0 : 80.0;
    final iconInnerSize = isMobile ? 22.0 : 28.0;
    final fontSize = isMobile ? 11.0 : 13.0;

    return AnimatedEntry(
      delay: Duration(milliseconds: delayMs),
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Magical Circle Icon
            MagicalHoverCard(
              width: iconSize,
              height: iconSize,
              borderRadius: BorderRadius.circular(100),
              elevation: 6,
              spotlightColor: AppColors.primary.withValues(alpha: 0.5),
              child: Center(
                child: custom.AnimatedIcon(
                  icon: icon,
                  size: iconInnerSize,
                  color: AppColors.primary,
                  hoverColor: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.deepSea,
                fontSize: fontSize,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
