import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/magical_hover_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  int _currentIndex = 0;

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
        final horizontalPadding = isMobile ? 16.0 : 48.0;
        final verticalPadding = isMobile ? 48.0 : 80.0;

        // Viewport fraction for carousel
        final viewportFraction = isMobile ? 0.9 : (isTablet ? 0.5 : 0.35);
        final cardHeight = isMobile ? 320.0 : 280.0;

        return Container(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          color: const Color(0xFFF5F0E8),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: AnimatedEntry(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: AppColors.deepSea,
                        fontSize: isMobile ? 24 : null,
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
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: AnimatedEntry(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    'Depoimentos reais de quem já se hospedou conosco via Booking.com',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: AppColors.deepSea.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),

              // Carousel instead of Wrap
              CarouselSlider.builder(
                itemCount: _testimonials.length,
                itemBuilder: (context, index, realIndex) {
                  return AnimatedEntry(
                    delay: Duration(milliseconds: 200 + index * 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: MagicalHoverCard(
                        borderRadius: BorderRadius.circular(16),
                        child: _buildTestimonialCard(
                          _testimonials[index],
                          isMobile,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: cardHeight,
                  viewportFraction: viewportFraction,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.1,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Pagination Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _testimonials.asMap().entries.map((entry) {
                  return Container(
                    width: _currentIndex == entry.key ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentIndex == entry.key
                          ? AppColors.primary
                          : AppColors.deepSea.withValues(alpha: 0.2),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: _buildBookingLink(isMobile),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBookingLink(bool isMobile) {
    return InkWell(
      onTap: () => launchUrl(
        Uri.parse(
          'https://www.booking.com/hotel/br/a-numero-1-suites.pt-br.html',
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: isMobile
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/booking_logo.png',
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          'Ver todas as avaliações',
                          style: TextStyle(
                            color: AppColors.deepSea.withValues(alpha: 0.7),
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.open_in_new,
                        size: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/booking_logo.png',
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Ver todas as avaliações no Booking.com',
                      style: TextStyle(
                        color: AppColors.deepSea.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
                ],
              ),
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial, bool isMobile) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with country and Booking badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🇧🇷', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    Text(
                      testimonial['country']!,
                      style: TextStyle(
                        color: AppColors.deepSea,
                        fontWeight: FontWeight.w500,
                        fontSize: isMobile ? 13 : 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/booking_logo.png',
                      height: isMobile ? 30 : 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 12,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'Verificado',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: isMobile ? 9 : 10,
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
            const SizedBox(height: 12),
            // Stars
            Row(
              children: List.generate(
                5,
                (_) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: isMobile ? 16 : 18,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Testimonial text
            Text(
              testimonial['text']!,
              style: TextStyle(
                color: AppColors.deepSea.withValues(alpha: 0.8),
                fontStyle: FontStyle.italic,
                height: 1.4,
                fontSize: isMobile ? 12 : 13,
              ),
            ),
            const SizedBox(height: 12),
            // Author
            Text(
              '— ${testimonial['name']}',
              style: TextStyle(
                color: AppColors.deepSea,
                fontWeight: FontWeight.bold,
                fontSize: isMobile ? 13 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
