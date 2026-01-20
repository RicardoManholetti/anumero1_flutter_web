import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/suite_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SuitesSection extends StatefulWidget {
  const SuitesSection({super.key});

  @override
  State<SuitesSection> createState() => _SuitesSectionState();
}

class _SuitesSectionState extends State<SuitesSection> {
  int _currentIndex = 0;

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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoints
        // Mobile: < 600px, Tablet: 600-1024px, Desktop: > 1024px
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

        // Viewport fraction determines how many cards are visible
        // Mobile: 0.85 (single card with peek), Tablet: 0.5 (2 cards), Desktop: 0.33 (3 cards)
        final viewportFraction = isMobile ? 0.85 : (isTablet ? 0.5 : 0.33);

        // Card height adapts to screen size
        final cardHeight = isMobile ? 520.0 : 580.0;

        // Responsive padding
        final horizontalPadding = isMobile ? 16.0 : 48.0;
        final verticalPadding = isMobile ? 60.0 : 100.0;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Column(
            children: [
              // Section Header
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
                      // Responsive font size
                      fontSize: isMobile ? 28 : null,
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
                    fontSize: isMobile ? 15 : 18,
                    color: AppColors.text.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: isMobile ? 32 : 64),

              // Carousel Slider - Replaces Wrap for horizontal swiping
              CarouselSlider.builder(
                itemCount: _suites.length,
                itemBuilder: (context, index, realIndex) {
                  final suite = _suites[index];
                  return AnimatedEntry(
                    delay: Duration(milliseconds: 200 + (index * 100)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SuiteCard(
                        title: suite['title'] as String,
                        capacity: suite['capacity'] as String,
                        description: suite['description'] as String,
                        imageUrls: List<String>.from(suite['images'] as List),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: cardHeight,
                  viewportFraction: viewportFraction,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.15,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Pagination Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _suites.asMap().entries.map((entry) {
                  return Container(
                    width: _currentIndex == entry.key ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentIndex == entry.key
                          ? AppColors.accent
                          : AppColors.text.withValues(alpha: 0.3),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
