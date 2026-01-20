import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/suite_card.dart';
import 'package:flutter/material.dart';

class SuitesSection extends StatelessWidget {
  const SuitesSection({super.key});

  // Define each suite with unique images
  static const List<Map<String, dynamic>> _suites = [
    {
      'title': 'Suíte Família',
      'capacity': 'Até 5 pessoas',
      'description':
          'Espaço amplo com cama de casal e beliches. Ideal para famílias com crianças.',
      'images': [
        'assets/suite-familia/Suite-familia1.jpg',
        'assets/suite-familia/Suite-familia2.jpg',
        'assets/suite-familia/Suite-familia3.jpg',
        'assets/suite-familia/Suite-familia4.jpg',
      ],
    },
    {
      'title': 'Estúdio Família com Cozinha',
      'capacity': 'Até 6 pessoas',
      'description':
          'Nossa maior suíte, perfeita para grupos grandes. Possui duas camas de casal e cozinha.',
      'images': [
        'assets/estudio-familia-com-cozinha/Estudio-familia-com-cozinha2.jpg',
        'assets/estudio-familia-com-cozinha/Estudio-familia-com-cozinha4.jpg',
        'assets/estudio-familia-com-cozinha/Estudio-familia-com-cozinha1.jpg',
        'assets/estudio-familia-com-cozinha/Estudio-familia-com-cozinha3.jpg',
        'assets/estudio-familia-com-cozinha/Estudio-familia-com-cozinha5.jpg',
      ],
    },
    {
      'title': 'Estúdio Família',
      'capacity': 'Até 5 pessoas',
      'description':
          'Layout compacto e funcional com cama de casal e sofá-cama.',
      'images': [
        'assets/quarto-familia/Quarto-Familia1.jpg',
        'assets/quarto-familia/Quarto-Familia2.jpg',
        'assets/quarto-familia/Quarto-Familia3.jpg',
        'assets/quarto-familia/Quarto-Familia4.jpg',
        'assets/quarto-familia/Quarto-Familia5.jpg',
      ],
    },
    {
      'title': 'Suíte com Varanda',
      'capacity': 'Até 2 pessoas',
      'description':
          'Perfeita para casais. Varanda privativa com vista para a área de lazer.',
      'images': [
        'assets/suite-casal-com-varanda/Suite-Casal-com-Varanda1.jpg',
        'assets/suite-casal-com-varanda/Suite-Casal-com-Varanda2.jpg',
        'assets/suite-casal-com-varanda/Suite-Casal-com-Varanda3.jpg',
        'assets/suite-casal-com-varanda/Suite-Casal-com-Varanda4.jpg',
        'assets/suite-casal-com-varanda/Suite-Casal-com-Varanda5.jpg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
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
                'Acomodações',
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
                  const TextSpan(text: 'Nossas '),
                  TextSpan(
                    text: 'Suítes',
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
              'Conforto e qualidade para sua estadia perfeita em Guarapari.',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.text.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              // Responsive grid
              final cardWidth = constraints.maxWidth > 1200
                  ? 380.0
                  : constraints.maxWidth > 800
                  ? 340.0
                  : constraints.maxWidth - 48;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: _suites.asMap().entries.map((entry) {
                  final index = entry.key;
                  final suite = entry.value;
                  return AnimatedEntry(
                    delay: Duration(milliseconds: 200 + (index * 100)),
                    child: SizedBox(
                      width: cardWidth,
                      height: 600, // Increased height to prevent overflow
                      child: SuiteCard(
                        title: suite['title'] as String,
                        capacity: suite['capacity'] as String,
                        description: suite['description'] as String,
                        imageUrls: List<String>.from(suite['images'] as List),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
