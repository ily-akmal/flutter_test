import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  const WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];

    return WeatherModel(
      cityName: json['name'] as String,
      temperature: (main['temp'] as num).toDouble() - 273.15,
      description: weather['description'] as String,
      icon: weather['icon'] as String,
    );
  }

  @override
  List<Object?> get props => [cityName, temperature, description, icon];
}
