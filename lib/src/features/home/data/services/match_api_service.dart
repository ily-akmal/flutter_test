import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/match_model.dart';

class MatchApiService {
  final Dio _dio;

  static const _rapidApiHost = 'cricbuzz-cricket.p.rapidapi.com';
  static const _baseUrl = 'https://cricbuzz-cricket.p.rapidapi.com/matches/v1';

  MatchApiService(this._dio);

  Future<List<MatchModel>> fetchMatches() async {
    final apiKey = dotenv.env['RAPID_API_KEY'] ?? '';
    final options = Options(
      headers: {'x-rapidapi-key': apiKey, 'x-rapidapi-host': _rapidApiHost},
    );

    // Fetch live, upcoming, and recent matches
    final responses = await Future.wait([
      _dio.get('$_baseUrl/live', options: options),
      _dio.get('$_baseUrl/upcoming', options: options),
      _dio.get('$_baseUrl/recent', options: options),
    ]);

    final List<MatchModel> allMatches = [];

    for (final response in responses) {
      final data = response.data;
      if (data != null && data['typeMatches'] != null) {
        for (final typeMatch in data['typeMatches']) {
          final seriesMatches = typeMatch['seriesMatches'] ?? [];
          for (final series in seriesMatches) {
            final wrapper = series['seriesAdWrapper'];
            if (wrapper == null) continue;

            final matchList = wrapper['matches'] ?? [];
            for (final match in matchList) {
              final matchInfo = match['matchInfo'];
              if (matchInfo == null) continue;

              if (match['matchScore'] != null) {
                matchInfo['matchScore'] = match['matchScore'];
              }

              allMatches.add(MatchModel.fromCricbuzzJson(matchInfo));
            }
          }
        }
      }
    }

    // Distinct matches by ID to avoid duplicates that may overlap between responses
    final uniqueMatches = <String, MatchModel>{};
    for (final m in allMatches) {
      uniqueMatches[m.id] = m;
    }

    return uniqueMatches.values.toList();
  }
}
