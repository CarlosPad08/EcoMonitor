import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/alert_banner.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/forecast_cards.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/recommendations_section.dart';

class AlertsContent extends StatelessWidget {
  const AlertsContent({super.key});

  @override
  Widget build(BuildContext context) {
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
            
            // Banner de alerta principal
            const AlertBanner(),
            const SizedBox(height: 20),
            
            // Cards de pronóstico
            const ForecastCards(),
            const SizedBox(height: 20),
            
            // Sección de recomendaciones
            const RecommendationsSection(),
            const SizedBox(height: 100), // Espacio para navegación
          ],
        ),
      ),
    );
  }
}
