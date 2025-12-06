import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_monitor/features/weather/presentation/providers/settings_provider.dart';

class ThemeSection extends ConsumerWidget {
  const ThemeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final themeMode = settings.themeMode;
    
    // Determinar qué opción está seleccionada
    String selectedTheme = 'Claro';
    if (themeMode == ThemeMode.dark) {
      selectedTheme = 'Oscuro';
    } else if (themeMode == ThemeMode.system) {
      selectedTheme = 'Automático';
    }

    // Obtener colores del tema actual
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final onSurface = colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tema',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildRadioOption(
              context,
              'Oscuro',
              selectedTheme == 'Oscuro',
              primaryColor,
              onSurface,
              () {
                ref.read(settingsProvider.notifier).setThemeMode(ThemeMode.dark);
              },
            ),
            const SizedBox(width: 20),
            _buildRadioOption(
              context,
              'Claro',
              selectedTheme == 'Claro',
              primaryColor,
              onSurface,
              () {
                ref.read(settingsProvider.notifier).setThemeMode(ThemeMode.light);
              },
            ),
            const SizedBox(width: 20),
            _buildRadioOption(
              context,
              'Automático',
              selectedTheme == 'Automático',
              primaryColor,
              onSurface,
              () {
                ref.read(settingsProvider.notifier).setThemeMode(ThemeMode.system);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(
    BuildContext context,
    String value,
    bool isSelected,
    Color primaryColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? primaryColor : Colors.transparent,
              border: Border.all(
                color: primaryColor,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
