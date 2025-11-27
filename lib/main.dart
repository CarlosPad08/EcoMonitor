import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_monitor/shared/themes/app_theme.dart';
import 'package:eco_monitor/features/weather/presentation/pages/home_page.dart';
import 'package:eco_monitor/features/weather/presentation/providers/settings_provider.dart';
import 'package:eco_monitor/core/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize notification service (loads alerts from JSON and schedules them)
  try {
    await NotificationService().init();
    debugPrint('✅ Notification service initialized');
  } catch (e) {
    debugPrint('❌ Notification service initialization error: $e');
  }
  
  runApp(
    const ProviderScope(
      child: EcoMonitorApp(),
    ),
  );
}

class EcoMonitorApp extends ConsumerWidget {
  const EcoMonitorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'EcoMonitor',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      /// 🌙 Cambio dinámico según configuración del usuario
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}



