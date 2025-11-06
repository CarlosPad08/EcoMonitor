import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';

class WeatherMockDataSource {
  static List<WeatherData> getMockData() {
    final now = DateTime.now();
    
    return [
      WeatherData(
        id: '1',
        createdAt: now,
        temperature: 29.0,
        humidity: 65.0,
        pressure: 1013.25,
        windSpeed: 12.3,
        windDirection: 180.0,
        rainfall: 0.0,
      ),
      WeatherData(
        id: '2',
        createdAt: now.subtract(const Duration(hours: 1)),
        temperature: 28.5,
        humidity: 68.0,
        pressure: 1012.80,
        windSpeed: 8.5,
        windDirection: 165.0,
        rainfall: 0.0,
      ),
      WeatherData(
        id: '3',
        createdAt: now.subtract(const Duration(hours: 2)),
        temperature: 27.2,
        humidity: 72.0,
        pressure: 1011.50,
        windSpeed: 15.8,
        windDirection: 195.0,
        rainfall: 2.5,
      ),
      WeatherData(
        id: '4',
        createdAt: now.subtract(const Duration(hours: 3)),
        temperature: 26.0,
        humidity: 75.0,
        pressure: 1010.25,
        windSpeed: 18.2,
        windDirection: 210.0,
        rainfall: 5.0,
      ),
      WeatherData(
        id: '5',
        createdAt: now.subtract(const Duration(hours: 4)),
        temperature: 25.5,
        humidity: 78.0,
        pressure: 1009.80,
        windSpeed: 20.1,
        windDirection: 225.0,
        rainfall: 8.5,
      ),
    ];
  }
}
