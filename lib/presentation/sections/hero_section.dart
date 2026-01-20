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
            constraints: const BoxConstraints(
              maxWidth: 900, // Force wider dialog
              maxHeight: 600,
            ),
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
                    fontSize: 28, // Slightly smaller than 32 to fit better
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
                        end: const Offset(1.05, 1.05), // Subtle scale breathing
                        duration: const Duration(seconds: 15),
                        curve: Curves.easeInOut,
                      ),
            ),
          ),

          // 2. Centered Hero Content
          Positioned(
            top: 0,
            bottom: 200,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Floating Booking Badge
                FloatingWidget(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
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
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 53, 128, 1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '9.1',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Nota dos hóspedes',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.open_in_new,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Animated Title with TextReveal
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextReveal(
                            text: 'A NÚMERO 1 SUÍTES',
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  fontSize: 72,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1.0,
                                  height: 1.0,
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
                            startDelay: const Duration(milliseconds: 300),
                          ),
                          const SizedBox(height: 16),
                          AnimatedEntry(
                            delay: const Duration(milliseconds: 1500),
                            child: Text(
                              'A sua Pousada em Guarapari na Praia do Morro.\nAcomodações confortáveis com piscina, estacionamento\ne churrasqueira a 400m da praia.',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.95),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    height: 1.4,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedEntry(
                delay: const Duration(milliseconds: 600),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDateInput(
                            context,
                            'Check-in',
                            Icons.calendar_today,
                            _checkInDate,
                            () => _selectDate(context, true),
                          ),
                          _buildDivider(),
                          _buildDateInput(
                            context,
                            'Check-out',
                            Icons.calendar_today_outlined,
                            _checkOutDate,
                            () => _selectDate(context, false),
                          ),
                          _buildDivider(),
                          const SizedBox(width: 24),
                          PremiumButton(
                            text: 'RESERVAR VIA WHATSAPP',
                            onPressed: _openWhatsApp,
                            isPrimary: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateInput(
    BuildContext context,
    String label,
    IconData icon,
    DateTime? selectedDate,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 200,
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

  Widget _buildDivider() {
    return const SizedBox(width: 16);
  }
}
