import 'package:flutter/material.dart';

class RecommendationsSection extends StatelessWidget {
  const RecommendationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Se recomienda lo siguiente:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A148C),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildRecommendationItem(
            'Hidratación: Bebe agua constantemente, incluso si no tienes sed.',
          ),
          const SizedBox(height: 12),
          
          _buildRecommendationItem(
            'Protector solar: Aplica FPS 30 o más en toda la piel expuesta.',
          ),
          const SizedBox(height: 12),
          
          _buildRecommendationItem(
            'Ropa ligera y clara: Viste ropa holgada, de colores claros y que cubra la mayor cantidad de piel posible.',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6, right: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF4A148C),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: const Color(0xFF4A148C),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
