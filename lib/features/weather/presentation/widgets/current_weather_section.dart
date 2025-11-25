import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';

class CurrentWeatherSection extends StatelessWidget {
  final WeatherData weatherData;
  final bool useCelsius;

  const CurrentWeatherSection({
    super.key,
    required this.weatherData,
    required this.useCelsius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ubicación
          Text(
            'Tuluá, Valle del Cauca',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4A148C),
            ),
          ),
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icono
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    _getWeatherIcon(),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),

              // Temperatura con símbolo correcto
              Text(
                '${weatherData.temperature.toStringAsFixed(0)}°${useCelsius ? "C" : "F"}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getWeatherIcon() {
    if (weatherData.temperature > 30) {
      return 'assets/images/soleado.png';
    } else if (weatherData.humidity > 70) {
      return 'assets/images/lluvia.png';
    } else if (weatherData.humidity > 50) {
      return 'assets/images/solconnube.png';
    } else {
      return 'assets/images/sol_icono.png';
    }
  }
}

