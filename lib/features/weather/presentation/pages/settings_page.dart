import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/bottom_navigation.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/settings_content.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/fondo.png'),
            fit: BoxFit.cover,
            colorFilter: Theme.of(context).brightness == Brightness.dark
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  )
                : null,
          ),
        ),
        child: const SafeArea(
          child: SettingsContent(),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 3),
    );
  }
}
