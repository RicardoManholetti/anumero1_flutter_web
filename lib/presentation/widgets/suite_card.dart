import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/hover_lift_card.dart';
import 'package:anumero1_flutter_web/presentation/widgets/luxury_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuiteCard extends StatefulWidget {
  final String title;
  final String capacity;
  final String description;
  final List<String> imageUrls;

  const SuiteCard({
    super.key,
    required this.title,
    required this.capacity,
    required this.imageUrls,
    this.description = 'Espaço amplo e confortável, ideal para relaxar.',
  });

  @override
  State<SuiteCard> createState() => _SuiteCardState();
}

class _SuiteCardState extends State<SuiteCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _openGalleryModal(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) =>
          _GalleryModal(images: widget.imageUrls, initialIndex: initialIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive calculations based on available width
        final isCompact = constraints.maxWidth < 320;
        final cardPadding = isCompact ? 12.0 : 16.0;
        final titleFontSize = isCompact ? 16.0 : 18.0;
        final descFontSize = isCompact ? 12.0 : 13.0;

        // Image height as a percentage of available height (around 50%)
        // Use AspectRatio for consistent image display
        final imageHeight = constraints.maxHeight * 0.48;

        return HoverLiftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image Carousel with constrained height
              SizedBox(
                height: imageHeight.clamp(180, 280),
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: widget.imageUrls.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _openGalleryModal(context, index),
                          child: widget.imageUrls[index].startsWith('http')
                              ? Image.network(
                                  widget.imageUrls[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) =>
                                      Container(color: Colors.grey[200]),
                                )
                              : Image.asset(
                                  widget.imageUrls[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) =>
                                      Container(color: Colors.grey[200]),
                                ),
                        );
                      },
                    ),
                    // Left Arrow - only show on hover/larger screens
                    if (_currentPage > 0)
                      Positioned(
                        left: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: _buildNavButton(
                            icon: Icons.arrow_back_ios,
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ),
                    // Right Arrow
                    if (_currentPage < widget.imageUrls.length - 1)
                      Positioned(
                        right: 8,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: _buildNavButton(
                            icon: Icons.arrow_forward_ios,
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ),
                    // Dots Indicator
                    Positioned(
                      bottom: 8,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(widget.imageUrls.length, (
                          index,
                        ) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _currentPage == index ? 16 : 6,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: _currentPage == index
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.5),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section - Flexible
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Capacity
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontFamily: 'Playfair Display',
                                fontWeight: FontWeight.bold,
                                color: AppColors.deepSea,
                                fontSize: titleFontSize,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Capacity Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.people_outline,
                                  size: 12,
                                  color: AppColors.text,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  widget.capacity,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Description - truncated for compact
                      Expanded(
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            color: AppColors.text.withValues(alpha: 0.8),
                            height: 1.4,
                            fontSize: descFontSize,
                          ),
                          maxLines: isCompact ? 2 : 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // CTA Button - Full Width
                      SizedBox(
                        width: double.infinity,
                        child: LuxuryButton(
                          label: 'COTAR VALOR',
                          onPressed: () => _openWhatsApp(widget.title),
                          backgroundColor: AppColors.accent,
                          textColor: Colors.white,
                          compact: isCompact,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Gallery Link
                      Center(
                        child: TextButton.icon(
                          onPressed: () => _openGalleryModal(context, 0),
                          icon: const Icon(
                            Icons.collections_outlined,
                            size: 14,
                          ),
                          label: Text(
                            'Ver ${widget.imageUrls.length} fotos',
                            style: TextStyle(fontSize: isCompact ? 11 : 12),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.text.withValues(
                              alpha: 0.6,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            minimumSize: const Size(44, 36), // Touch target
                          ),
                        ),
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

  // Helper for navigation buttons with proper touch target
  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 16),
        ),
      ),
    );
  }

  void _openWhatsApp(String suiteName) {
    final message = Uri.encodeComponent('Olá! Gostaria de cotar a $suiteName.');
    launchUrl(Uri.parse('https://wa.me/5527999943870?text=$message'));
  }
}

// Gallery Modal Widget
class _GalleryModal extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _GalleryModal({required this.images, required this.initialIndex});

  @override
  State<_GalleryModal> createState() => _GalleryModalState();
}

class _GalleryModalState extends State<_GalleryModal> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image Viewer
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              final imagePath = widget.images[index];
              return InteractiveViewer(
                child: Center(
                  child: imagePath.startsWith('http')
                      ? Image.network(imagePath, fit: BoxFit.contain)
                      : Image.asset(imagePath, fit: BoxFit.contain),
                ),
              );
            },
          ),
          // Close Button
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Left Arrow
          if (_currentIndex > 0)
            Positioned(
              left: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          // Right Arrow
          if (_currentIndex < widget.images.length - 1)
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
          // Counter
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
