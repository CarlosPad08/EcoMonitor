import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/favorites_info_box.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/neighborhood_selector.dart';

class FavoritesContent extends StatelessWidget {
  const FavoritesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal
            Text(
              'Tus lugares favoritos en Tuluá, Valle del Cauca',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 20),
            
            // Caja de información
            const FavoritesInfoBox(),
            const SizedBox(height: 20),
            
            // Selector de barrios
            const NeighborhoodSelector(),
            const SizedBox(height: 100), // Espacio para navegación
          ],
        ),
      ),
    );
  }
}
