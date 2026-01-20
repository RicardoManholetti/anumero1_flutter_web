import 'dart:ui_web' as ui_web;

import 'package:anumero1_flutter_web/core/theme/app_theme.dart';
import 'package:anumero1_flutter_web/presentation/pages/home_page.dart';
import 'package:anumero1_flutter_web/presentation/widgets/cinematic_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:web/web.dart' as web;

void main() {
  // Register Google Maps iframe for Flutter Web
  ui_web.platformViewRegistry.registerViewFactory('google-maps-iframe', (
    int viewId,
  ) {
    final iframe = web.HTMLIFrameElement()
      ..src =
          'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3727.674987654321!2d-40.4851234!3d-20.6651234!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xb9c7c2c2c2c2c2%3A0x2c2c2c2c2c2c2c2c!2sPraia%20do%20Morro!5e0!3m2!1spt-BR!2sbr!4v1620000000000!5m2!1spt-BR!2sbr'
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..allowFullscreen = true
      ..title = 'Localização A Número 1 Suítes - Praia do Morro, Guarapari';
    iframe.setAttribute('loading', 'lazy');
    iframe.setAttribute('referrerpolicy', 'no-referrer-when-downgrade');
    return iframe;
  });

  runApp(const AnumeroApp());
}

class AnumeroApp extends StatelessWidget {
  const AnumeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A Número 1 Suítes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const CinematicLoader(
        duration: Duration(milliseconds: 300),
        child: HomePage(),
      ),
    );
  }
}
