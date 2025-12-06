import 'package:flutter/material.dart';

class FavoritesInfoBox extends StatelessWidget {
  const FavoritesInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.primary,
          width: 1,
        ),
      ),
      child: Text(
        'La selección de estos lugares le facilitará tener las notificaciones más rápidas y precisas de dicho lugar.',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: colorScheme.onPrimary,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
