import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';
import 'package:eco_monitor/shared/themes/app_theme.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherCard({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(weatherData.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Icon(
                  Icons.wb_sunny,
                  color: AppTheme.temperatureColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Temperatura',
                    '${weatherData.temperature.toStringAsFixed(1)}°C',
                    AppTheme.temperatureColor,
                    Icons.thermostat,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Humedad',
                    '${weatherData.humidity.toStringAsFixed(1)}%',
                    AppTheme.humidityColor,
                    Icons.water_drop,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context,
                    'Presión',
                    '${weatherData.pressure.toStringAsFixed(1)} hPa',
                    AppTheme.pressureColor,
                    Icons.speed,
                  ),
                ),
                if (weatherData.windSpeed != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildMetricCard(
                      context,
                      'Viento',
                      '${weatherData.windSpeed!.toStringAsFixed(1)} km/h',
                      AppTheme.windColor,
                      Icons.air,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
