import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';

class SettingsContent extends ConsumerWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------------
            // TITULO PRINCIPAL
            // ------------------------
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

            // ------------------------
            // SECCIÓN DE UNIDADES
            // ------------------------
            Text(
              "Unidades",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            SwitchListTile(
              title: const Text("Usar Celsius (°C)"),
              subtitle: const Text("Apagar para usar Fahrenheit (°F)"),
              value: settings.useCelsius,
              onChanged: notifier.toggleTemperatureUnit,
            ),
            SwitchListTile(
              title: const Text("Presión en hPa"),
              subtitle: const Text("Apagar para usar mmHg"),
              value: settings.useHpa,
              onChanged: notifier.togglePressureUnit,
            ),
            const SizedBox(height: 30),

            // ------------------------
            // SECCIÓN DE TEMA
            // ------------------------
            Text(
              "Tema",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            SwitchListTile(
              title: const Text("Modo oscuro"),
              value: settings.isDarkMode,
              onChanged: notifier.toggleDarkMode,
            ),
            const SizedBox(height: 30),

            // ------------------------
            // SECCIÓN DE NOTIFICACIONES (placeholder)
            // ------------------------
            Text(
              "Notificaciones",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 10),
            _placeholderBox("Configuración de notificaciones próximamente"),
            const SizedBox(height: 30),

            // ------------------------
            // SECCIÓN DE ALERTAS (placeholder)
            // ------------------------
            Text(
              "Alertas",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 10),
            _placeholderBox("Configuración de alertas próximamente"),
            const SizedBox(height: 100), // Espacio para navegación
          ],
        ),
      ),
    );
  }

  // ------------------------
  // WIDGET ESTÉTICO PARA PLACEHOLDERS
  // ------------------------
  Widget _placeholderBox(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4A148C)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}
