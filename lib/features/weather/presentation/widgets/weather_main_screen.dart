import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/current_weather_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/weather_metrics_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/forecast_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/alerts_section.dart';

// Provider correcto (si ya no lo necesitas, lo quitamos)
import 'package:eco_monitor/features/weather/presentation/providers/settings_provider.dart';

class WeatherMainScreen extends ConsumerWidget {
  final List<WeatherData> weatherData;

  // 🔥 Agregar los parámetros nuevos
  final bool useCelsius;
  final bool useHpa;

  const WeatherMainScreen({
    super.key,
    required this.weatherData,
    required this.useCelsius,  // ← agregado
    required this.useHpa,      // ← agregado
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestData = weatherData.isNotEmpty ? weatherData.first : null;

    if (latestData == null) {
      return const Center(child: Text("No hay datos del clima"));
    }

    // -------------------------------
    // 🔥 Funciones de conversión
    // -------------------------------

    // °C → °F
    double convertTemp(double celsius) =>
        useCelsius ? celsius : (celsius * 9 / 5) + 32;

    // hPa → mmHg
    double convertPressure(double hpa) =>
        useHpa ? hpa : hpa * 0.750062;

    // 💡 Copiamos el WeatherData con valores ya convertidos
    final WeatherData convertedData = latestData.copyWith(
      temperature: convertTemp(latestData.temperature),
      pressure: convertPressure(latestData.pressure),
    );

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
                // 🌤 Temperatura actual con símbolo °C/°F correcto
                CurrentWeatherSection(
                  weatherData: convertedData,
                  useCelsius: useCelsius,
                ),
                const SizedBox(height: 20),

                // 📊 Métricas con hPa o mmHg correcto
                WeatherMetricsSection(
                  weatherData: convertedData,
                  useHpa: useHpa,
                ),
                const SizedBox(height: 30),

                // 📅 Pronóstico con grados correctos
                ForecastSection(
                  useCelsius: useCelsius,
                ),
                const SizedBox(height: 30),

                // 🚨 Alertas
                const AlertsSection(),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




