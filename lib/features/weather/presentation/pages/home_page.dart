import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_monitor/features/weather/presentation/providers/weather_provider.dart';
import 'package:eco_monitor/features/weather/presentation/providers/settings_provider.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/loading_widget.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/error_widget.dart' as custom;
import 'package:eco_monitor/features/weather/presentation/widgets/weather_main_screen.dart';
import 'package:eco_monitor/features/weather/presentation/widgets/bottom_navigation.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherNotifierProvider);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: weatherState.when(
        data: (weatherData) {
          if (weatherData.isEmpty) {
            return const Center(
              child: Text('No hay datos disponibles'),
            );
          }

          return WeatherMainScreen(
            weatherData: weatherData,
            useCelsius: settings.useCelsius,
            useHpa: settings.useHpa,
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => custom.ErrorWidget(error: error.toString()),
      ),
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
    );
  }
}

