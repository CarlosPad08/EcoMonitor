import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eco_monitor/features/weather/presentation/providers/settings_provider.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/alert_banner.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/forecast_cards.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/recommendations_section.dart';

class AlertsContent extends ConsumerWidget {
  const AlertsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔥 Lee los ajustes en tiempo real desde Riverpod
    final settings = ref.watch(settingsProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal
            Text(
              'Tuluá, Valle del Cauca',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 8),

            // Subtítulo
            Text(
              'Alertas en tiempo real',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 20),

            // 🔥 Banner de alerta con formato dinámico
            AlertBanner(
              useCelsius: settings.useCelsius,
              useHpa: settings.useHpa,
            ),
            const SizedBox(height: 20),

            // 🔥 Tarjetas de pronóstico con formato dinámico
            ForecastCards(
              useCelsius: settings.useCelsius,
              useHpa: settings.useHpa,
            ),
            const SizedBox(height: 20),

            // 🔥 Recomendaciones con unidades dinámicas
            RecommendationsSection(
              useCelsius: settings.useCelsius,
              useHpa: settings.useHpa,
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

