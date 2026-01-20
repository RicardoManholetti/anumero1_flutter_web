import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/floating_widget.dart';
import 'package:anumero1_flutter_web/presentation/widgets/magical_hover_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isWide = constraints.maxWidth > 900;
        final horizontalPadding = isMobile ? 16.0 : 48.0;
        final verticalPadding = isMobile ? 48.0 : 100.0;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          color: const Color(0xFFF9F9F9),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildImage(isMobile)),
                    const SizedBox(width: 64),
                    Expanded(child: _buildContent(context, isMobile)),
                  ],
                )
              : Column(
                  children: [
                    _buildImage(isMobile),
                    const SizedBox(height: 32),
                    _buildContent(context, isMobile),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildImage(bool isMobile) {
    return AnimatedEntry(
      child: FloatingWidget(
        amplitude: isMobile ? 5 : 10,
        duration: const Duration(seconds: 4),
        child: Container(
          height: isMobile ? 280 : 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/foto-piscina.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    final features = [
      {
        'icon': FontAwesomeIcons.shoePrints,
        'title': 'Apenas 5min andando pra praia',
      },
      {'icon': FontAwesomeIcons.water, 'title': 'Piscina ao Ar Livre'},
      {
        'icon': FontAwesomeIcons.snowflake,
        'title': 'Ar-Condicionado em todas as suítes',
      },
      {'icon': FontAwesomeIcons.fireBurner, 'title': 'Área de Churrasqueira'},
      {
        'icon': FontAwesomeIcons.car,
        'title': 'Estacionamento Privativo Grátis',
      },
      {'icon': FontAwesomeIcons.paw, 'title': 'Permitido Animais de Estimação'},
      {
        'icon': FontAwesomeIcons.solidSnowflake,
        'title': 'Geladeira em todas as suítes',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedEntry(
          delay: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Sobre Nós',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedEntry(
          delay: const Duration(milliseconds: 200),
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                height: 1.1,
              ),
              children: [
                const TextSpan(text: 'CONFORTO E LAZER '),
                TextSpan(
                  text: 'PERTINHO DA PRAIA',
                  style: TextStyle(color: AppColors.accent),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        AnimatedEntry(
          delay: const Duration(milliseconds: 300),
          child: Text(
            'A Número 1 Suítes oferece a estrutura completa que sua família merece. Estamos a apenas 400m da Praia do Morro — apenas 5 minutos andando! Com piscina ao ar livre, estacionamento grátis e área de churrasco, somos o refúgio ideal para quem busca preço justo sem abrir mão do conforto.',
            style: TextStyle(
              fontSize: 18,
              height: 1.6,
              color: AppColors.text.withValues(alpha: 0.8),
            ),
          ),
        ),
        const SizedBox(height: 48),
        AnimatedEntry(
          delay: const Duration(milliseconds: 400),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculate how many cards fit per row (2 columns on narrow, 3 on wide)
              final cardsPerRow = constraints.maxWidth > 500 ? 3 : 2;
              final cardWidth =
                  (constraints.maxWidth - (cardsPerRow - 1) * 12) / cardsPerRow;

              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: features
                    .asMap()
                    .entries
                    .map(
                      (entry) => AnimatedEntry(
                        delay: Duration(milliseconds: 500 + (entry.key * 100)),
                        child: _buildFeatureCard(
                          icon: entry.value['icon'] as IconData,
                          title: entry.value['title'] as String,
                          width: cardWidth.clamp(140.0, 200.0),
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    double width = 200,
  }) {
    // Premium Magical Card implementation - flexible height for text wrapping
    return MagicalHoverCard(
      width: width,
      height: 100, // Increased height to accommodate wrapped text
      backgroundColor: AppColors.primary,
      spotlightColor: AppColors.accent,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  height: 1.3,
                  letterSpacing: 0.3,
                ),
                // Allow text to wrap naturally - no maxLines or overflow.ellipsis
              ),
            ),
          ],
        ),
      ),
    );
  }
}
