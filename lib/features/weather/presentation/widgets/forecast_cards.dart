import 'package:flutter/material.dart';

class ForecastCards extends StatelessWidget {
  const ForecastCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildForecastCard(
            time: 'Ahora',
            icon: 'assets/images/solconnube.png',
            temperature: '32°',
            precipitation: '30%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildForecastCard(
            time: 'En 2H',
            icon: 'assets/images/solconnube.png',
            temperature: '33°',
            precipitation: '38%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildForecastCard(
            time: 'En 5H',
            icon: 'assets/images/solconnube.png',
            temperature: '29°',
            precipitation: '28%',
          ),
        ),
      ],
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
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
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
              color: const Color(0xFF4A148C),
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
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A148C),
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
