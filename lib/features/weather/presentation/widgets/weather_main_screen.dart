import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/current_weather_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/weather_metrics_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/forecast_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/alerts_section.dart';

class WeatherMainScreen extends StatelessWidget {
  final List<WeatherData> weatherData;

  const WeatherMainScreen({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final latestData = weatherData.isNotEmpty ? weatherData.first : null;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/fondo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Sección principal del clima
                if (latestData != null) ...[
                  CurrentWeatherSection(weatherData: latestData),
                  const SizedBox(height: 20),
                  
                  // Métricas del clima
                  WeatherMetricsSection(weatherData: latestData),
                  const SizedBox(height: 30),
                  
                  // Pronóstico
                  const ForecastSection(),
                  const SizedBox(height: 30),
                  
                  // Alertas
                  const AlertsSection(),
                  const SizedBox(height: 100), // Espacio para navegación inferior
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
