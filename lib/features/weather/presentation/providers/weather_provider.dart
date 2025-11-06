import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';
import 'package:eco_monitor/features/weather/data/datasources/weather_mock_datasource.dart';

// Provider simple que solo usa datos mock
final weatherDataProvider = FutureProvider<List<WeatherData>>((ref) async {
  // Simular carga de 2 segundos
  await Future.delayed(const Duration(seconds: 2));
  return WeatherMockDataSource.getMockData();
});

// Notifier simple para manejar el estado
class WeatherNotifier extends StateNotifier<AsyncValue<List<WeatherData>>> {
  WeatherNotifier() : super(const AsyncValue.loading()) {
    loadWeatherData();
  }

  Future<void> loadWeatherData() async {
    state = const AsyncValue.loading();
    try {
      // Simular carga de 2 segundos
      await Future.delayed(const Duration(seconds: 2));
      final data = WeatherMockDataSource.getMockData();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  void refresh() {
    loadWeatherData();
  }
}

final weatherNotifierProvider = StateNotifierProvider<WeatherNotifier, AsyncValue<List<WeatherData>>>((ref) {
  return WeatherNotifier();
});
