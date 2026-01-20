import 'package:anumero1_flutter_web/presentation/sections/about_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/amenities_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/footer_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/gallery_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/hero_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/location_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/suites_section.dart';
import 'package:anumero1_flutter_web/presentation/sections/testimonials_section.dart';
import 'package:anumero1_flutter_web/presentation/widgets/nav_bar.dart';
import 'package:anumero1_flutter_web/presentation/widgets/whatsapp_fab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (_) => GlobalKey());
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  void _scrollToSection(int index) {
    if (index < _sectionKeys.length) {
      final context = _sectionKeys[index].currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[0],
                  child: const HeroSection(),
                ),
              ),
              const SliverToBoxAdapter(child: AboutSection()),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const SuitesSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const AmenitiesSection(),
                ),
              ),
              const SliverToBoxAdapter(child: GallerySection()),
              const SliverToBoxAdapter(child: TestimonialsSection()),
              SliverToBoxAdapter(
                child: KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const LocationSection(),
                ),
              ),
              SliverToBoxAdapter(
                child: FooterSection(onNavTap: _scrollToSection),
              ),
            ],
          ),

          // Fixed Floating NavBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(onNavTap: _scrollToSection, isScrolled: _isScrolled),
          ),

          const WhatsAppFab(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
