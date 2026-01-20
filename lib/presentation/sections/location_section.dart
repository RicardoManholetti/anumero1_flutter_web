import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Slate Blue Background for Section
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
      color: const Color(0xFF426F80), // Slate Blue matching reference
      child: Column(
        children: [
          AnimatedEntry(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Localização',
                style: TextStyle(
                  color: Colors.white,
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
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                children: [
                  const TextSpan(text: 'Localização '),
                  TextSpan(
                    text: 'Estratégica',
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
              'Fácil acesso às melhores praias e ao comércio local.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          // Booking Badge White Pill - Clickable
          InkWell(
            onTap: () => launchUrl(
              Uri.parse(
                'https://www.booking.com/hotel/br/a-numero-1-suites.pt-br.html',
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/booking_logo.png',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 53, 128, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '9.1',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Geral', style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 53, 128, 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '9.3',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Localização',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.open_in_new, size: 14, color: Colors.grey),
                ],
              ),
            ),
          ),

          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _buildMap()),
                        const SizedBox(width: 48),
                        Expanded(flex: 4, child: _buildInfoColumn(context)),
                      ],
                    )
                  : Column(
                      children: [
                        _buildMap(),
                        const SizedBox(height: 32),
                        _buildInfoColumn(context),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    // Google Maps iframe embed using HtmlElementView
    return AnimatedEntry(
      delay: const Duration(milliseconds: 300),
      child: Container(
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Google Maps iframe
            const SizedBox.expand(
              child: HtmlElementView(viewType: 'google-maps-iframe'),
            ),
            // Open in Google Maps Button overlay
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton.icon(
                onPressed: () => launchUrl(
                  Uri.parse('https://maps.app.goo.gl/3HHnCsLjS6CnV4bY8'),
                ),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Abrir no Google Maps'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const FaIcon(
                FontAwesomeIcons.locationArrow,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'A Número 1 Suítes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Guarapari, ES',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 28,
              ), // Pin Icon
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Endereço',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'R. Francisco Ramalhete Gameiro, 233\nPraia do Morro, Guarapari - ES\nCEP: 29216-420',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Localizada em área tranquila, a Número 1 Suítes oferece fácil acesso às principais praias e pontos turísticos de Guarapari. Ficamos próximos a mercados, padarias, restaurantes e hortifruti — tudo o que você precisa sem precisar ir longe!',
          style: TextStyle(color: Colors.white, height: 1.5),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.access_time, color: AppColors.accent, size: 20),
            const SizedBox(width: 8),
            Text(
              'Distâncias',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Distance Cards
        Row(
          children: [
            Expanded(child: _buildDistanceCard('Praia do Morro', '400m')),
            const SizedBox(width: 16),
            Expanded(child: _buildDistanceCard('Centro', '4 km')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildDistanceCard('Praia da Cerca', '1 km')),
            const SizedBox(width: 16),
            Expanded(child: _buildDistanceCard('Morro da Pescaria', '1 km')),
          ],
        ),
      ],
    );
  }

  Widget _buildDistanceCard(String place, String distance) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(place, style: TextStyle(color: Colors.grey[700])),
          ),
          Text(
            distance,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
