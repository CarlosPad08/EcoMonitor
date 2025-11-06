import 'package:dio/dio.dart';
import 'package:eco_monitor/core/constants/app_constants.dart';
import 'package:eco_monitor/core/errors/failures.dart';
import 'package:eco_monitor/core/network/dio_client.dart';
import 'package:eco_monitor/features/weather/domain/entities/weather_data.dart';

abstract class WeatherRemoteDataSource {
  Future<List<WeatherData>> getWeatherData({int results = 10});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final DioClient _dioClient;

  WeatherRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<WeatherData>> getWeatherData({int results = 10}) async {
    try {
      final response = await _dioClient.dio.get(
        AppConstants.feedsEndpoint,
        queryParameters: {
          'results': results,
          'api_key': AppConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> feeds = response.data['feeds'] ?? [];
        return feeds.map((feed) => WeatherData.fromJson(feed)).toList();
      } else {
        throw const ServerFailure('Error al obtener datos del servidor');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkFailure('Error de conexión');
      } else {
        throw ServerFailure('Error del servidor: ${e.message}');
      }
    } catch (e) {
      throw UnknownFailure('Error inesperado: $e');
    }
  }
}
