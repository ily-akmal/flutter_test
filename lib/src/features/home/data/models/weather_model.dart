import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String icon; // We'll map WMO weather codes to an icon string/url

  const WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] ?? {};
    final temp = (current['temperature_2m'] as num?)?.toDouble() ?? 0.0;
    final code = current['weather_code'] as int? ?? 0;

    return WeatherModel(
      cityName:
          'Colombo', // Open-Meteo doesn't return geocoding names in standard forecast
      temperature: temp,
      description: _mapWmoCodeToDescription(code),
      icon: _mapWmoCodeToIcon(code),
    );
  }

  // WMO Weather interpretation codes (simplified)
  static String _mapWmoCodeToDescription(int code) {
    if (code == 0) return 'Clear sky';
    if (code >= 1 && code <= 3) return 'Partly cloudy';
    if (code >= 45 && code <= 48) return 'Foggy';
    if (code >= 51 && code <= 55) return 'Drizzle';
    if (code >= 61 && code <= 65) return 'Rain';
    if (code >= 71 && code <= 77) return 'Snow';
    if (code >= 80 && code <= 82) return 'Rain showers';
    if (code >= 95) return 'Thunderstorm';
    return 'Unknown';
  }

  static String _mapWmoCodeToIcon(int code) {
    if (code == 0) return 'assets/icons/sun.png'; // placeholder icon names
    if (code >= 1 && code <= 3) return 'assets/icons/cloud.png';
    if (code >= 61 && code <= 65 || code >= 80 && code <= 82) {
      return 'assets/icons/rain.png';
    }
    return 'assets/icons/cloud.png';
  }

  @override
  List<Object?> get props => [cityName, temperature, description, icon];
}
