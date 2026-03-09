import 'package:equatable/equatable.dart';

abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class FetchMatches extends MatchEvent {}
