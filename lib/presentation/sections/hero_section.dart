import 'dart:ui';

import 'package:anumero1_flutter_web/core/theme/app_colors.dart';
import 'package:anumero1_flutter_web/presentation/widgets/animated_entry.dart';
import 'package:anumero1_flutter_web/presentation/widgets/floating_widget.dart';
import 'package:anumero1_flutter_web/presentation/widgets/parallax_wrapper.dart';
import 'package:anumero1_flutter_web/presentation/widgets/premium_button.dart';
import 'package:anumero1_flutter_web/presentation/widgets/text_reveal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      anchorPoint: const Offset(0, 200),
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate: isCheckIn
          ? (_checkInDate ?? now)
          : (_checkOutDate ??
                (_checkInDate?.add(const Duration(days: 1)) ??
                    now.add(const Duration(days: 1)))),
      firstDate: isCheckIn ? now : (_checkInDate ?? now),
      lastDate: now.add(const Duration(days: 365)),
      helpText: isCheckIn ? 'Check-in' : 'Check-out',
      cancelText: 'Cancelar',
      builder: (context, child) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900, maxHeight: 600),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary,
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: AppColors.deepSea,
                ),
                datePickerTheme: DatePickerThemeData(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  headerHeadlineStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  headerHelpStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              child: child!,
            ),
          ),
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          if (_checkOutDate != null && _checkOutDate!.isBefore(picked)) {
            _checkOutDate = null;
          }
        } else {
          _checkOutDate = picked;
        }
      });
    }
  }

  void _openWhatsApp() {
    String message;
    if (_checkInDate != null && _checkOutDate != null) {
      message = Uri.encodeComponent(
        'Olá! Gostaria de obter mais informações sobre a reserva para as datas:\n'
        'Check-in: ${_dateFormat.format(_checkInDate!)}\n'
        'Check-out: ${_dateFormat.format(_checkOutDate!)}',
      );
    } else {
      message = Uri.encodeComponent(
        'Olá! Gostaria de consultar disponibilidade para a Pousada A Número 1.',
      );
    }
    launchUrl(Uri.parse('https://wa.me/5511947243870?text=$message'));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive breakpoints
        final screenWidth = constraints.maxWidth;
        final isMobile = screenWidth < 600;
        final isTablet = screenWidth >= 600 && screenWidth < 1024;

        // Responsive values
        final titleFontSize = isMobile ? 32.0 : (isTablet ? 48.0 : 72.0);
        final subtitleFontSize = isMobile ? 14.0 : (isTablet ? 18.0 : 24.0);
        final contentPadding = isMobile ? 16.0 : 40.0;
        final bookingFormBottom = isMobile ? 40.0 : 150.0;
        final heroContentBottom = isMobile ? 160.0 : 200.0;

        return Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: AppColors.background,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Parallax Background
              Positioned.fill(
                child: ParallaxWrapper(
                  parallaxFactor: 0.5,
                  child:
                      Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              image: const DecorationImage(
                                image: AssetImage(
                                  'assets/images/foto_pousada_geral.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: AppColors.heroOverlay,
                              ),
                            ),
                          )
                          .animate(
                            onPlay: (controller) =>
                                controller.repeat(reverse: true),
                          )
                          .scale(
                            begin: const Offset(1.0, 1.0),
                            end: const Offset(1.05, 1.05),
                            duration: const Duration(seconds: 15),
                            curve: Curves.easeInOut,
                          ),
                ),
              ),

              // 2. Centered Hero Content
              Positioned(
                top: 0,
                bottom: heroContentBottom,
                left: 0,
                right: 0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: isMobile ? 80 : 120),

                      // Floating Booking Badge - Responsive
                      if (!isMobile) _buildBookingBadge(isMobile, isTablet),
                      if (!isMobile) const SizedBox(height: 32),

                      // Animated Title with TextReveal - Responsive
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: contentPadding,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            isMobile ? 16 : 30,
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 20 : 40,
                                vertical: isMobile ? 20 : 30,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(
                                  isMobile ? 16 : 30,
                                ),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.1),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Mobile: Show badge inside title card
                                  if (isMobile) ...[
                                    _buildCompactBookingBadge(),
                                    const SizedBox(height: 16),
                                  ],
                                  TextReveal(
                                    text: 'A NÚMERO 1 SUÍTES',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                          fontSize: titleFontSize,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: isMobile ? 0 : -1.0,
                                          height: 1.1,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.5,
                                              ),
                                              blurRadius: 20,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                    textAlign: TextAlign.center,
                                    startDelay: const Duration(
                                      milliseconds: 300,
                                    ),
                                  ),
                                  SizedBox(height: isMobile ? 12 : 16),
                                  AnimatedEntry(
                                    delay: const Duration(milliseconds: 1500),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 0 : 20,
                                      ),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                color: Colors.white.withValues(
                                                  alpha: 0.95,
                                                ),
                                                fontWeight: FontWeight.w500,
                                                fontSize: subtitleFontSize,
                                                height: 1.4,
                                                shadows: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withValues(alpha: 0.5),
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'A sua Pousada em Guarapari na Praia do Morro.\nAcomodações confortáveis com ',
                                            ),
                                            TextSpan(
                                              text:
                                                  'piscina, estacionamento\ne churrasqueira',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.accent,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: ' a 400m da praia.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Booking Form - Responsive
              Positioned(
                bottom: bookingFormBottom,
                left: isMobile ? 16 : 0,
                right: isMobile ? 16 : 0,
                child: Center(
                  child: AnimatedEntry(
                    delay: const Duration(milliseconds: 600),
                    child: _buildBookingForm(context, isMobile, isTablet),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Booking badge for desktop/tablet
  Widget _buildBookingBadge(bool isMobile, bool isTablet) {
    return FloatingWidget(
      amplitude: 6,
      duration: const Duration(seconds: 4),
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(
            'https://www.booking.com/hotel/br/a-numero-1-suites.pt-br.html',
          ),
        ),
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 32,
            vertical: isTablet ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/booking_logo.png',
                height: isTablet ? 50 : 70,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 53, 128, 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '9.1',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 14 : 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Nota dos hóspedes',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: isTablet ? 14 : 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // Compact booking badge for mobile (inside title card)
  Widget _buildCompactBookingBadge() {
    return InkWell(
      onTap: () => launchUrl(
        Uri.parse(
          'https://www.booking.com/hotel/br/a-numero-1-suites.pt-br.html',
        ),
      ),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/booking_logo.png',
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 53, 128, 1),
                borderRadius: BorderRadius.circular(3),
              ),
              child: const Text(
                '9.1',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.open_in_new, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Responsive booking form
  Widget _buildBookingForm(BuildContext context, bool isMobile, bool isTablet) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 16 : 24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: isMobile
              ? _buildMobileBookingForm(context)
              : _buildDesktopBookingForm(context, isTablet),
        ),
      ),
    );
  }

  // Mobile: Vertical stacked layout
  Widget _buildMobileBookingForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDateInputCompact(
                context,
                'CHECK-IN',
                Icons.calendar_today,
                _checkInDate,
                () => _selectDate(context, true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateInputCompact(
                context,
                'CHECK-OUT',
                Icons.calendar_today_outlined,
                _checkOutDate,
                () => _selectDate(context, false),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: PremiumButton(
            text: 'RESERVAR VIA WHATSAPP',
            onPressed: _openWhatsApp,
            isPrimary: true,
            compact: true,
          ),
        ),
      ],
    );
  }

  // Desktop/Tablet: Horizontal layout
  Widget _buildDesktopBookingForm(BuildContext context, bool isTablet) {
    final inputWidth = isTablet ? 160.0 : 200.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDateInput(
          context,
          'Check-in',
          Icons.calendar_today,
          _checkInDate,
          () => _selectDate(context, true),
          inputWidth,
        ),
        const SizedBox(width: 16),
        _buildDateInput(
          context,
          'Check-out',
          Icons.calendar_today_outlined,
          _checkOutDate,
          () => _selectDate(context, false),
          inputWidth,
        ),
        const SizedBox(width: 24),
        PremiumButton(
          text: isTablet ? 'RESERVAR' : 'RESERVAR VIA WHATSAPP',
          onPressed: _openWhatsApp,
          isPrimary: true,
        ),
      ],
    );
  }

  // Compact date input for mobile (fits in row)
  Widget _buildDateInputCompact(
    BuildContext context,
    String label,
    IconData icon,
    DateTime? selectedDate,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.text.withValues(alpha: 0.5),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(icon, size: 14, color: AppColors.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? _dateFormat.format(selectedDate)
                        : 'Selecione',
                    style: TextStyle(
                      color: selectedDate != null
                          ? AppColors.text
                          : AppColors.text.withValues(alpha: 0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Full date input for desktop
  Widget _buildDateInput(
    BuildContext context,
    String label,
    IconData icon,
    DateTime? selectedDate,
    VoidCallback onTap,
    double width,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: AppColors.text.withValues(alpha: 0.5),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, size: 18, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  selectedDate != null
                      ? _dateFormat.format(selectedDate)
                      : 'Selecione',
                  style: TextStyle(
                    color: selectedDate != null
                        ? AppColors.text
                        : AppColors.text.withValues(alpha: 0.5),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
