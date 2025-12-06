import 'package:flutter/material.dart';

class RecommendationsSection extends StatelessWidget {
  final bool useCelsius;
  final bool useHpa;

  const RecommendationsSection({
    super.key,
    required this.useCelsius,
    required this.useHpa,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.3),
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
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),

          _buildRecommendationItem(
            context,
            'Hidratación: Bebe agua constantemente.',
          ),
          const SizedBox(height: 12),

          _buildRecommendationItem(
            context,
            'Protector solar: Aplica FPS 30 o más.',
          ),
          const SizedBox(height: 12),

          _buildRecommendationItem(
            context,
            'Ropa ligera y clara: Prefiere prendas frescas.',
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 6, right: 12),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

