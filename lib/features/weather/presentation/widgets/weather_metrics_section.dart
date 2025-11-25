import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';

class WeatherMetricsSection extends StatelessWidget {
  final WeatherData weatherData;
  final bool useHpa;

  const WeatherMetricsSection({
    super.key,
    required this.weatherData,
    required this.useHpa,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricItem(
              icon: 'assets/images/gota2_icono_rellena.png',
              value: '${weatherData.humidity.toStringAsFixed(0)}%',
              label: 'Humedad',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMetricItem(
              icon: 'assets/images/presion_icono.png',
              value:
                  '${weatherData.pressure.toStringAsFixed(0)} ${useHpa ? "hPa" : "mmHg"}',
              label: 'Presión',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMetricItem(
              icon: 'assets/images/nube_icono.png',
              value: 'Moderado',
              label: 'Nubosidad',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildMetricItem(
              icon: 'assets/images/sol_icono.png',
              value: '550 w/m²',
              label: 'Radiación',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10,
              color: const Color(0xFF4A148C).withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

