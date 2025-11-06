import 'package:eco_monitor/core/errors/failures.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';
import 'package:eco_monitor/features/weather/domain/repositories/weather_repository.dart';

class GetWeatherData {
  final WeatherRepository _repository;

  GetWeatherData(this._repository);

  Future<List<WeatherData>> call({int results = 10}) async {
    return await _repository.getWeatherData(results: results);
  }
}

class GetLatestWeatherData {
  final WeatherRepository _repository;

  GetLatestWeatherData(this._repository);

  Future<WeatherData?> call() async {
    return await _repository.getLatestWeatherData();
  }
}
