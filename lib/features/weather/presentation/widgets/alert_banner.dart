import 'package:flutter/material.dart';

class AlertBanner extends StatelessWidget {
  final bool useCelsius;
  final bool useHpa;

  const AlertBanner({
    super.key,
    required this.useCelsius,
    required this.useHpa,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Usar color naranja para alertas, adaptado al tema
    final alertColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.orange.shade700
        : Colors.orange.shade400;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: alertColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: alertColor,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.warning,
              color: colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alta radiación solar, use protector solar',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ver más detalles',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
