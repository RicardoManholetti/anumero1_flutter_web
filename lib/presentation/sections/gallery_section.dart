import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/image_gallery_modal.dart';
import 'package:anumero1_flutter_web/presentation/widgets/magical_hover_card.dart';
import 'package:flutter/material.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80),
      color: Colors.white,
      child: Column(
        children: [
          // Header
          AnimatedEntry(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepSea,
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
          const SizedBox(height: 16),
          AnimatedEntry(
            delay: const Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Espaços pensados para proporcionar conforto e momentos inesquecíveis durante sua estadia.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.text.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Gallery Grid
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: _items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;

                  // Responsive card width calculation
                  double cardWidth = 500;
                  if (constraints.maxWidth < 550) {
                    cardWidth =
                        constraints.maxWidth - 48; // Full width - padding
                  } else if (constraints.maxWidth < 1100 &&
                      _items.length == 3) {
                    // If on medium screen with 3 items, maybe make them smaller to fit 2 or keep 500
                    // Let's stick to 500 max width or adjust if container is smaller
                    cardWidth = 500;
                  }

                  return AnimatedEntry(
                    delay: Duration(milliseconds: 300 + (index * 100)),
                    child: MagicalHoverCard(
                      width: cardWidth,
                      height: 400,
                      borderRadius: BorderRadius.circular(20),
                      child: _buildGalleryCard(item),
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

  Widget _buildGalleryCard(Map<String, dynamic> item) {
    return InkWell(
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
                stops: const [0.5, 1.0],
              ),
            ),
          ),
          // Text Content with Icon hint
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['title']! as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.collections_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item['description']! as String,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
