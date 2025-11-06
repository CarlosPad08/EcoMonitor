import 'package:eco_monitor/core/errors/failures.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';

abstract class WeatherRepository {
  Future<List<WeatherData>> getWeatherData({int results = 10});
  Future<WeatherData?> getLatestWeatherData();
}
