import 'package:flutter/material.dart';

class ForecastCards extends StatelessWidget {
  final bool useCelsius;
  final bool useHpa;

  const ForecastCards({
    super.key,
    required this.useCelsius,
    required this.useHpa,
  });

  String _formatTemp(int celsius) {
  if (useCelsius) return "$celsius°C";

  final f = (celsius * 9 / 5) + 32;
  return "${f.toStringAsFixed(0)}°F";
}


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildForecastCard(
            time: 'Ahora',
            icon: 'assets/images/solconnube.png',
            tempCelsius: 32,
            precipitation: '30%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildForecastCard(
            time: 'En 2H',
            icon: 'assets/images/solconnube.png',
            tempCelsius: 33,
            precipitation: '38%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildForecastCard(
            time: 'En 5H',
            icon: 'assets/images/solconnube.png',
            tempCelsius: 29,
            precipitation: '28%',
          ),
        ),
      ],
    );
  }

  Widget _buildForecastCard({
    required String time,
    required String icon,
    required int tempCelsius,
    required String precipitation,
  }) {
    final tempText = _formatTemp(tempCelsius);

    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),

              Image.asset(
                icon,
                width: 32,
                height: 32,
              ),

              const SizedBox(height: 8),
              Text(
                tempText,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 4),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/gota_icono_borde.png',
                    width: 12,
                    height: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    precipitation,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

