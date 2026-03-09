import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weather.cityName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  weather.description,
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${weather.temperature.toStringAsFixed(1)}°',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                // Since this is a test, we will show dynamic icons from Material icons as a fallback representation
                _buildWeatherIcon(weather.description),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherIcon(String desc) {
    IconData iconData = Icons.cloud;
    final lowerDesc = desc.toLowerCase();

    if (lowerDesc.contains('clear')) {
      iconData = Icons.wb_sunny;
    } else if (lowerDesc.contains('rain') || lowerDesc.contains('drizzle')) {
      iconData = Icons.grain;
    } else if (lowerDesc.contains('thunder')) {
      iconData = Icons.flash_on;
    }

    return Icon(iconData, color: Colors.white, size: 48);
  }
}
