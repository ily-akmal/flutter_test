import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/weather_model.dart';

class WeatherApiService {
  final Dio _dio;

  WeatherApiService(this._dio);

  Future<WeatherModel> fetchWeather() async {
    final baseUrl =
        dotenv.env['WEATHER_API_URL'] ??
        'https://api.open-meteo.com/v1/forecast';
    final lat = dotenv.env['WEATHER_LAT'] ?? '6.9271';
    final lon = dotenv.env['WEATHER_LON'] ?? '79.8612';

    final response = await _dio.get(
      baseUrl,
      queryParameters: {
        'latitude': lat,
        'longitude': lon,
        'current': 'temperature_2m,weather_code',
      },
    );

    return WeatherModel.fromJson(response.data);
  }
}
