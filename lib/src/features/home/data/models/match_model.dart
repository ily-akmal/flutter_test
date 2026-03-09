import 'package:equatable/equatable.dart';

class MatchModel extends Equatable {
  final String id;
  final String matchTitle;
  final String teamOne;
  final String teamTwo;
  final String scoreOne;
  final String scoreTwo;
  final String date;
  final String status;

  const MatchModel({
    required this.id,
    required this.matchTitle,
    required this.teamOne,
    required this.teamTwo,
    required this.scoreOne,
    required this.scoreTwo,
    required this.date,
    required this.status,
  });

  // parses the cricbuzz match info into a flat model we can display
  factory MatchModel.fromCricbuzzJson(Map<String, dynamic> matchInfo) {
    final team1 = matchInfo['team1'] ?? {};
    final team2 = matchInfo['team2'] ?? {};
    final venueInfo = matchInfo['venueInfo'] ?? {};
    final status = matchInfo['status'] ?? matchInfo['state'] ?? 'Unknown';

    // scores come from the scorecard, but the match list doesn't always have them
    // we'll pull what we can from matchScore if it exists
    String scoreOne = '-';
    String scoreTwo = '-';

    if (matchInfo['matchScore'] != null) {
      final matchScore = matchInfo['matchScore'];
      final team1Score = matchScore['team1Score'];
      final team2Score = matchScore['team2Score'];

      if (team1Score != null && team1Score['inngs1'] != null) {
        final inngs = team1Score['inngs1'];
        scoreOne = '${inngs['runs']}/${inngs['wickets']} (${inngs['overs']})';
      }
      if (team2Score != null && team2Score['inngs1'] != null) {
        final inngs = team2Score['inngs1'];
        scoreTwo = '${inngs['runs']}/${inngs['wickets']} (${inngs['overs']})';
      }
    }

    return MatchModel(
      id: (matchInfo['matchId'] ?? 0).toString(),
      matchTitle: matchInfo['matchDesc'] ?? 'Match',
      teamOne: team1['teamSName'] ?? 'TBA',
      teamTwo: team2['teamSName'] ?? 'TBA',
      scoreOne: scoreOne,
      scoreTwo: scoreTwo,
      date: venueInfo['timezone'] ?? matchInfo['startDate'] ?? '-',
      status: status.toString(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    matchTitle,
    teamOne,
    teamTwo,
    scoreOne,
    scoreTwo,
    date,
    status,
  ];
}
