import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/settings_provider.dart';
import 'theme_section.dart';

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
                color: Theme.of(context).colorScheme.onSurface,
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
                color: Theme.of(context).colorScheme.onSurface,
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
            const ThemeSection(),
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
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            _placeholderBox(context, "Configuración de notificaciones próximamente"),
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
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 10),
            _placeholderBox(context, "Configuración de alertas próximamente"),
            const SizedBox(height: 100), // Espacio para navegación
          ],
        ),
      ),
    );
  }

  // ------------------------
  // WIDGET ESTÉTICO PARA PLACEHOLDERS
  // ------------------------
  Widget _placeholderBox(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.primary),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
