import 'package:eco_monitor/core/errors/failures.dart';
import 'package:eco_monitor/features/weather/data/datasources/weather_remote_datasource.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';
import 'package:eco_monitor/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource _remoteDataSource;

  WeatherRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<WeatherData>> getWeatherData({int results = 10}) async {
    try {
      return await _remoteDataSource.getWeatherData(results: results);
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Error inesperado: $e');
    }
  }

  @override
  Future<WeatherData?> getLatestWeatherData() async {
    try {
      final data = await _remoteDataSource.getWeatherData(results: 1);
      return data.isNotEmpty ? data.first : null;
    } on Failure {
      rethrow;
    } catch (e) {
      throw UnknownFailure('Error inesperado: $e');
    }
  }
}
