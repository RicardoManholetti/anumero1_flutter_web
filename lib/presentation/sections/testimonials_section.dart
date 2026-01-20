import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/magical_hover_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const List<Map<String, String>> _testimonials = [
    {
      'name': 'Sanderson',
      'country': 'Brasil',
      'text':
          '"Fomos muito bem recebidos e instalados, uma excelente estrutura e perto de tudo, dá pra ir caminhando a praia, tem padaria, supermercado, posto de gasolina, vários comércios."',
    },
    {
      'name': 'Evandro',
      'country': 'Brasil',
      'text':
          '"Instalações muito boa, piscina ótima é perto de tudo, bares, praia, supermercado e lanchonete e os anfitriões são muito receptivos e atenciosos."',
    },
    {
      'name': 'Lucas',
      'country': 'Brasil',
      'text':
          '"A recepção e a simplicidade dos anfitriões é exemplar. Nos sentimos em casa e confortáveis. Tudo a base do respeito mútuo. Estão de parabéns pela hospitalidade."',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 48),
      color: const Color(0xFFF5F0E8), // Warm cream background
      child: Column(
        children: [
          AnimatedEntry(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppColors.deepSea,
                ),
                children: [
                  const TextSpan(text: 'O Que Dizem Nossos '),
                  TextSpan(
                    text: 'Hóspedes',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedEntry(
            delay: const Duration(milliseconds: 100),
            child: Text(
              'Depoimentos reais de quem já se hospedou conosco via Booking.com',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.deepSea.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              final cardWidth = isWide
                  ? (constraints.maxWidth - 48) /
                        3 // 3 columns with gap
                  : constraints.maxWidth > 600
                  ? (constraints.maxWidth - 24) /
                        2 // 2 columns
                  : constraints.maxWidth; // 1 column

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: _testimonials.asMap().entries.map((entry) {
                  return SizedBox(
                    width: cardWidth,
                    child: AnimatedEntry(
                      delay: Duration(milliseconds: 200 + entry.key * 100),
                      child: MagicalHoverCard(
                        borderRadius: BorderRadius.circular(16),
                        child: _buildTestimonialCard(entry.value),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 48),
          // Booking.com Link
          InkWell(
            onTap: () => launchUrl(
              Uri.parse(
                'https://www.booking.com/hotel/br/a-numero-1-suites.pt-br.html',
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/booking_logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ver todas as avaliações no Booking.com',
                  style: TextStyle(
                    color: AppColors.deepSea.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.open_in_new, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with country and Booking badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('🇧🇷', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    testimonial['country']!,
                    style: TextStyle(
                      color: AppColors.deepSea,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/booking_logo.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.verified, size: 14, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          'Verificado',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Stars
          Row(
            children: List.generate(
              5,
              (_) => const Icon(Icons.star, color: Colors.amber, size: 18),
            ),
          ),
          const SizedBox(height: 16),
          // Testimonial text
          Text(
            testimonial['text']!,
            style: TextStyle(
              color: AppColors.deepSea.withValues(alpha: 0.8),
              fontStyle: FontStyle.italic,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Author
          Text(
            '— ${testimonial['name']}',
            style: TextStyle(
              color: AppColors.deepSea,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
