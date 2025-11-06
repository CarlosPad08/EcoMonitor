import 'package:flutter/material.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/units_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/theme_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/notifications_section.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/alerts_section.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

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
              'CONFIGURACIONES',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 30),
            
            // Sección de unidades
            const UnitsSection(),
            const SizedBox(height: 30),
            
            // Sección de tema
            const ThemeSection(),
            const SizedBox(height: 30),
            
            // Sección de notificaciones
            const NotificationsSection(),
            const SizedBox(height: 30),
            
            // Sección de alertas
            const AlertsSection(),
            const SizedBox(height: 100), // Espacio para navegación
          ],
        ),
      ),
    );
  }
}
