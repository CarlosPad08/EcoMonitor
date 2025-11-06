import 'package:flutter/material.dart';

class ForecastSection extends StatelessWidget {
  const ForecastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          Text(
            'Pronóstico',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A148C),
            ),
          ),
          const SizedBox(height: 16),
          
          // Cards de pronóstico
          Row(
            children: [
              Expanded(
                child: _buildForecastCard(
                  time: 'Ahora',
                  icon: 'assets/images/solconnube.png',
                  temperature: '29°',
                  precipitation: '30%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildForecastCard(
                  time: '2 PM',
                  icon: 'assets/images/lluvia.png',
                  temperature: '15°',
                  precipitation: '60%',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildForecastCard(
                  time: '3 PM',
                  icon: 'assets/images/lluvia.png',
                  temperature: '15°',
                  precipitation: '70%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Botón de pronóstico extendido
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF9C27B0).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                'ver pronósticos extendidos (7 días)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4A148C),
                ),
              ),
            ),
          ),
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
