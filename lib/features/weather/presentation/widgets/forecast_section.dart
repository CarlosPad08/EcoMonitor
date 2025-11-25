import 'package:flutter/material.dart';

class ForecastSection extends StatelessWidget {
  final bool useCelsius;

  const ForecastSection({
    super.key,
    required this.useCelsius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pronóstico',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A148C),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildForecastCard(
                  time: 'Ahora',
                  icon: 'assets/images/solconnube.png',
                  temperature: '29°${useCelsius ? "C" : "F"}',
                  precipitation: '30%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildForecastCard(
                  time: '2 PM',
                  icon: 'assets/images/lluvia.png',
                  temperature: '15°${useCelsius ? "C" : "F"}',
                  precipitation: '60%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildForecastCard(
                  time: '3 PM',
                  icon: 'assets/images/lluvia.png',
                  temperature: '15°${useCelsius ? "C" : "F"}',
                  precipitation: '70%',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildForecastCard({
    required String time,
    required String icon,
    required String temperature,
    required String precipitation,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF9C27B0).withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF9C27B0).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
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
            temperature,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A148C),
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
                  color: const Color(0xFF4A148C).withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

