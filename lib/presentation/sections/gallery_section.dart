import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/image_gallery_modal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Piscina ao Ar Livre',
      'description': 'Área de lazer com piscina para relaxar',
      'image': 'assets/images/foto-piscina.jpeg',
      'images': [
        'assets/images/foto-piscina.jpeg',
        'assets/images/piscina1.jpg',
        'assets/images/piscina2.jpg',
        'assets/images/piscina3.jpg',
        'assets/images/piscina4.jpg',
      ],
    },
    {
      'title': 'Cozinha Completa e Churrasqueira',
      'description': 'Cozinha compartilhada totalmente equipada',
      'image': 'assets/images/area-churrasco1jpg.jpg',
      'images': [
        'assets/images/area-churrasco1jpg.jpg',
        'assets/images/area-churrasco2.jpg',
        'assets/images/area-churrasco3.jpg',
      ],
    },
    {
      'title': 'Estacionamento',
      'description': 'Vagas disponíveis para hóspedes',
      'image': 'assets/images/estacionamento.jpg',
      'images': [
        'assets/images/estacionamento.jpg',
        'assets/images/estacionamento3.jpg',
        'assets/images/foto_pousada_geral.jpg',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoints
        final isMobile = constraints.maxWidth < 600;
        final isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1024;

        // Viewport fraction: mobile shows 1 card, tablet shows 2, desktop shows all 3
        final viewportFraction = isMobile ? 0.88 : (isTablet ? 0.5 : 0.33);

        // Responsive card height
        final cardHeight = isMobile ? 320.0 : 380.0;

        // Responsive padding
        final verticalPadding = isMobile ? 48.0 : 80.0;

        return Container(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          color: Colors.white,
          child: Column(
            children: [
              // Header
              AnimatedEntry(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.champagne,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Galeria',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedEntry(
                delay: const Duration(milliseconds: 100),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepSea,
                        fontSize: isMobile ? 26 : null,
                      ),
                      children: [
                        const TextSpan(text: 'Conheça Nossa '),
                        TextSpan(
                          text: 'Estrutura',
                          style: TextStyle(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedEntry(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 24),
                  child: Text(
                    'Espaços pensados para proporcionar conforto e momentos inesquecíveis durante sua estadia.',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      color: AppColors.text.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 32 : 48),

              CarouselSlider.builder(
                itemCount: _items.length,
                itemBuilder: (context, index, realIndex) {
                  final item = _items[index];
                  return AnimatedEntry(
                    delay: Duration(milliseconds: 300 + (index * 100)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: _buildGalleryCard(item, isMobile),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: cardHeight,
                  viewportFraction: viewportFraction,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.12,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _items.asMap().entries.map((entry) {
                  return Container(
                    width: _currentIndex == entry.key ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentIndex == entry.key
                          ? AppColors.accent
                          : AppColors.text.withValues(alpha: 0.2),
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

  Widget _buildGalleryCard(Map<String, dynamic> item, bool isMobile) {
    final titleFontSize = isMobile ? 18.0 : 22.0;
    final descFontSize = isMobile ? 12.0 : 14.0;
    final contentPadding = isMobile ? 16.0 : 24.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierColor: Colors.black.withValues(alpha: 0.9),
            builder: (context) =>
                ImageGalleryModal(images: item['images'] as List<String>),
          );
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item['image']! as String, fit: BoxFit.cover),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
            // Text Content with Icon hint
            Positioned(
              bottom: contentPadding,
              left: contentPadding,
              right: contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item['title']! as String,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.collections_outlined,
                        color: Colors.white.withValues(alpha: 0.8),
                        size: isMobile ? 20 : 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['description']! as String,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: descFontSize,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
