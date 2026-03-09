import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/match_model.dart';

class MatchApiService {
  final Dio _dio;

  static const _rapidApiHost = 'cricbuzz-cricket.p.rapidapi.com';

  MatchApiService(this._dio);

  Future<List<MatchModel>> fetchMatches() async {
    final apiKey = dotenv.env['RAPID_API_KEY'] ?? '';

    final response = await _dio.get(
      'https://cricbuzz-cricket.p.rapidapi.com/matches/v1/recent',
      options: Options(
        headers: {'x-rapidapi-key': apiKey, 'x-rapidapi-host': _rapidApiHost},
      ),
    );

    final List<MatchModel> matches = [];
    final data = response.data;

    if (data['typeMatches'] != null) {
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

            matches.add(MatchModel.fromCricbuzzJson(matchInfo));
          }
        }
      }
    }

    return matches;
  }
}
