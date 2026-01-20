import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/magical_hover_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final Function(int)? onNavTap; // Callback for navigation

  const FooterSection({super.key, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 80, bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 800;
                return isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2, child: _buildAboutColumn(context)),
                          const SizedBox(width: 48),
                          Expanded(child: _buildNavColumn(context)),
                          const SizedBox(width: 48),
                          Expanded(
                            flex: 2,
                            child: _buildContactColumn(context),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAboutColumn(context),
                          const SizedBox(height: 48),
                          _buildNavColumn(context),
                          const SizedBox(height: 48),
                          _buildContactColumn(context),
                        ],
                      );
              },
            ),
          ),
          const SizedBox(height: 80),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 20),
          Text(
            'A Número 1 Suítes © ${DateTime.now().year}. Todos os direitos reservados.',
            style: TextStyle(
              color: AppColors.deepSea.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Image
        Container(
          color: AppColors.primary,
          child: Image.asset(
            'assets/images/logo_footer.png',
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          children: [
            Text(
              'Fundada em 2012 por ',
              style: TextStyle(
                color: AppColors.deepSea.withValues(alpha: 0.8),
                height: 1.6,
                fontSize: 14,
              ),
            ),
            Text(
              'Paulo e Jô',
              style: TextStyle(
                color: AppColors.deepSea.withValues(alpha: 0.8),
                height: 1.3,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'A Número 1 Suítes nasceu de um sonho que se tornou realidade. Até hoje, recebemos nossos hóspedes com o mesmo carinho do primeiro dia.',
              style: TextStyle(
                color: AppColors.deepSea.withValues(alpha: 0.8),
                height: 1.6,
                fontSize: 14,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        Row(
          children: [
            _buildSocialIcon(
              FontAwesomeIcons.instagram,
              'https://www.instagram.com/anumero1suitesguarapari/',
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              FontAwesomeIcons.facebookF,
              'https://www.facebook.com/anumero1suites',
            ),
            const SizedBox(width: 12),
            _buildSocialIcon(
              FontAwesomeIcons.whatsapp,
              'https://wa.me/+5511947243870',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(12),
      child: MagicalHoverCard(
        width: 44,
        height: 44,
        borderRadius: BorderRadius.circular(12),
        backgroundColor: const Color(0xFFF5F5F5),
        spotlightColor: AppColors.accent.withValues(alpha: 0.3),
        elevation: 0,
        child: Center(child: FaIcon(icon, size: 20, color: AppColors.deepSea)),
      ),
    );
  }

  Widget _buildNavColumn(BuildContext context) {
    final navItems = [
      {'text': 'Início', 'index': 0},
      {'text': 'Acomodações', 'index': 1},
      {'text': 'Estrutura', 'index': 2},
      {'text': 'Localização', 'index': 3},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Navegação',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.deepSea,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 24),
        ...navItems.map(
          (item) => _buildNavLink(item['text'] as String, item['index'] as int),
        ),
      ],
    );
  }

  Widget _buildNavLink(String text, int sectionIndex) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onNavTap?.call(sectionIndex),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.deepSea.withValues(alpha: 0.8),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contato',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.deepSea,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () => launchUrl(Uri.parse('tel:+5511947243870')),
          child: Row(
            children: [
              Icon(Icons.phone_outlined, size: 18, color: AppColors.deepSea),
              const SizedBox(width: 8),
              Text(
                '(11) 94724-3870',
                style: TextStyle(
                  color: AppColors.deepSea,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Atendimento direto com os proprietários',
          style: TextStyle(
            color: AppColors.deepSea.withValues(alpha: 0.5),
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 18,
              color: AppColors.deepSea,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'R. Francisco Ramalhete Gameiro, 233\nPraia do Morro, Guarapari - ES\nCEP: 29216-420',
                style: TextStyle(
                  color: AppColors.deepSea.withValues(alpha: 0.8),
                  height: 1.5,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
