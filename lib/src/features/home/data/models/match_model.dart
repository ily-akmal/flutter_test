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

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String,
      matchTitle: json['matchTitle'] as String,
      teamOne: json['teamOne'] as String,
      teamTwo: json['teamTwo'] as String,
      scoreOne: json['scoreOne'] as String,
      scoreTwo: json['scoreTwo'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
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
